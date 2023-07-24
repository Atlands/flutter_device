import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device/model/package.dart';

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

  @override
  Future<String?> cameraPicker() async {
    String? result = await methodChannel.invokeMethod('camera_picker');
    return result;
  }

  @override
  Future<Package> getPackageInfo() async {
    String result = await methodChannel.invokeMethod('get_package_info');
    return Package.fromJson(jsonDecode(result));
  }

  @override
  Future<String> getDeviceId() async {
    String result = await methodChannel.invokeMethod('device_id');
    return result;
  }

  @override
  Future<Map<String, dynamic>> getReferrer() async {
    String result = await methodChannel.invokeMethod('install_referrer');
    return jsonDecode(result);
  }
}
