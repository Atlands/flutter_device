import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_device_platform_interface.dart';
import 'model/contact.dart';

/// An implementation of [FlutterDevicePlatform] that uses method channels.
class MethodChannelFlutterDevice extends FlutterDevicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_device');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Contact?> contactPicker() async {
    String? result = await methodChannel.invokeMethod('contact_picker');
    if (result == null) return null;
    return Contact.fromJson(jsonDecode(result));
  }
}
