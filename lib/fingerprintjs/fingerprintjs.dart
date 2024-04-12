@JS()
library fingerprintjs;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:js/js.dart';

part 'options.dart';

// @JS('Promise')
// class Promise<T> {
//   external Promise(void executor(void resolve(T result), Function reject));
//
//   external Promise then(void onFulfilled(T result), [Function onRejected]);
// }

@JS('localStorage')
class LocalStorage {
  external static setItem(String key, dynamic value);

  external static dynamic getItem(String key);
}

@JS('Fingerprint2')
class _Fingerprint {
  external static dynamic get(Options? options, Function action);

  external static String x64hash128(String values, int seed);
}

/// Stores the key/value pair of fingerprint properties
@JS()
@anonymous
class FingerprintComponent {
  /// The key for a fingerprint property
  external String key;

  /// The value for a fingerprint property
  external dynamic value;

// FingerprintComponent({this.key, this.value});
}

/// A wrapper for the fingerprintjs library
class Fingerprint {
  /// Returns an array of `FingerprintComponent` which contains
  /// all the components extracted from the browser
  static Future<List<FingerprintComponent>> get({Options? options}) {
    final completer = Completer<List<FingerprintComponent>>();
    Timer(const Duration(milliseconds: 500), () {
      _Fingerprint.get(options, allowInterop((components) {
        completer.complete(components.cast<FingerprintComponent>());
      }));
    });
    return completer.future;
  }

  /// Used to create a hash fingerprint
  static String x64hash128(String key, int seed) {
    return _Fingerprint.x64hash128(key, seed);
  }

  /// Create a fingerprint hash from the properties extracted
  static Future<String> getHash() async {
    var components = await Fingerprint.get();
    var values = components.map((component) => component.value);
    return Fingerprint.x64hash128(values.join(''), 31);
  }
}

Future<String> getIPAddress() async {
  try {
    final result =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (result.statusCode != 200) {
      throw Exception('http get err ${result.statusCode}');
    }
    final ipAddress = jsonDecode(result.body)['ip'];
    return ipAddress;
  } catch (e) {
    debugPrint('Error fetching IP address: $e');
    return '192.168.0.1';
  }
}


FutureOr<String> getVisitorId() async {
  try {
    var visitorId = LocalStorage.getItem('visitorId') as String?;
    if (visitorId != null && visitorId.isNotEmpty) {
      return visitorId;
    }
    var components = await Fingerprint.get();
    var ip = await getIPAddress();
    components.add(FingerprintComponent()
      ..key = "ip"
      ..value = ip);
    var values = components.asMap().keys.map((key) {
      var component = components[key];
      if (key == 0) {
        return (component.value as String).replaceAll("/\bNetType\/\w+\b/", "");
      }
      return component.value;
    }).toList();

    visitorId = Fingerprint.x64hash128(values.join(), 31);
    LocalStorage.setItem('visitorId', visitorId);
    return visitorId;
  } catch (e) {
    return Fingerprint.getHash();
  }
}
