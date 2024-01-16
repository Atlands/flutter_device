// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:fingerprintjs/fingerprintjs.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device/model/contact.dart';
import 'package:flutter_device/model/package.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:intl/intl.dart';

import 'flutter_device_platform_interface.dart';

/// A web implementation of the FlutterDevicePlatform of the FlutterDevice plugin.
class FlutterDeviceWeb extends FlutterDevicePlatform {
  /// Constructs a FlutterDeviceWeb
  FlutterDeviceWeb();

  static void registerWith(Registrar registrar) {
    FlutterDevicePlatform.instance = FlutterDeviceWeb();
  }

  @override
  Future<bool> cleanPreferences() async {
    return true;
  }

  @override
  Future<bool> savePreferences(Map<String, dynamic> map) async {
    return true;
  }

  @override
  Future<List> getCalLogs() async {
    return [];
  }

  @override
  Future<List> getCalendars() async {
    return [];
  }

  @override
  Future<List> getContacts() async {
    return [];
  }

  @override
  Future<List> getMessages() async {
    return [];
  }

  @override
  Future<List> getPhotos() async {
    return [];
  }

  @override
  Future<List> getApps() async {
    return [];
  }

  @override
  Future<Map<String, dynamic>> getPosition() async {
    try {
      var geolocation = await window.navigator.geolocation
          .getCurrentPosition(enableHighAccuracy: true);
      if (geolocation.coords == null) return {};
      return {
        "position_x": geolocation.coords?.latitude,
        "position_y": geolocation.coords?.longitude,
        "geo_time": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };
    } catch (e) {
      return {};
      throw PlatformException(code: '000', message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    // var id = await getDeviceId();
    var system = 'other';
    if (RegExp(r'(iPhone|iPad|iPod|iOS|Mac)')
        .hasMatch(window.navigator.userAgent)) {
      system = "ios";
    } else if (RegExp(r'(Android)').hasMatch(window.navigator.userAgent)) {
      system = "android";
    } else {
      system = "other";
    }
    // var geolocation = await window.navigator.geolocation
    //     .getCurrentPosition(enableHighAccuracy: true);
    Map<String, dynamic>? position;
    try {
      position = await getPosition();
      print(position);
    } catch (e) {
      print(e);
    }

    return {
      'w': window.screen?.width ?? 0 * window.devicePixelRatio,
      'h': window.screen?.height ?? 0 * window.devicePixelRatio,
      'system': system,
      'latitude': position?['position_x'],
      'longitude': position?['position_y'],
      'hasOwnProperty': false,
      'appCodeName': window.navigator.appCodeName,
      'appName': window.navigator.appName,
      'appVersion': window.navigator.appVersion,
      'platform': window.navigator.platform,
      'userAgent': window.navigator.userAgent,
      'vendor': window.navigator.vendor,
    };
  }

  @override
  Future<String> getSystem() async {
    // var id = await getDeviceId();
    var system = 'other';
    if (RegExp(r'(iPhone|iPad|iPod|iOS|Mac)')
        .hasMatch(window.navigator.userAgent)) {
      system = "ios";
    } else if (RegExp(r'(Android)').hasMatch(window.navigator.userAgent)) {
      system = "android";
    } else {
      system = "other";
    }
    return system;
  }

  @override
  Future<Map<String, dynamic>> getReferrer() async {
    var uri = Uri.dataFromString(window.location.href);
    var qp = uri.queryParameters;
    var channel = qp['channel'] ?? "unknown";
    var referrer = "utm_source=$channel";
    return {
      'referrer': referrer,
      'download_time': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };
  }

  @override
  Future<String> getDeviceId() async {
    var visitorId = await Fingerprint.getHash();
    return visitorId;
  }

  @override
  Future<Package> getPackageInfo() async {
    return Package(appName: '', packageName: '', versionName: '');
  }

  @override
  Future<String?> cameraPicker(
      {double? maxWidth,
      double? maxHeight,
      int? imageQuality,
      bool? front}) async {
    var file = await ImagePickerPlugin().getImageFromSource(
        source: ImageSource.camera,
        options: ImagePickerOptions(
            maxWidth: maxHeight,
            maxHeight: maxHeight,
            imageQuality: imageQuality,
            preferredCameraDevice:
                (front ?? false) ? CameraDevice.rear : CameraDevice.front));
    return file?.path;
  }

  @override
  Future<Contact?> contactPicker() async {
    return null;
  }
}
