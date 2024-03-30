import 'dart:convert';
import 'dart:io';

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
  Future<Contact?> contactPicker() async {
    String? result = await methodChannel.invokeMethod('contact_picker');
    if (result == null) return null;
    return Contact.fromJson(jsonDecode(result));
  }

  @override
  Future<String?> cameraPicker(
      {double? maxWidth,
      double? maxHeight,
      int? imageQuality,
      bool? front}) async {
    String? result = await methodChannel.invokeMethod('camera_picker', {
      "maxWidth": maxWidth,
      "maxHeight": maxHeight,
      "imageQuality": imageQuality,
      "front": front,
    });
    return result;
  }

  @override
  Future<Package> getPackageInfo() async {
    String result = await methodChannel.invokeMethod('package_info');
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

  @override
  Future<List> getCalLogs() async {
    String result = await methodChannel.invokeMethod('call_logs_list');
    return jsonDecode(result);
  }

  @override
  Future<List> getCalendars() async {
    String result = await methodChannel.invokeMethod('calendar_list');
    return jsonDecode(result);
  }

  @override
  Future<List> getContacts() async {
    String result = await methodChannel.invokeMethod('contact_list');
    return jsonDecode(result);
  }

  @override
  Future<List> getMessages() async {
    String result = await methodChannel.invokeMethod('sms_list');
    return jsonDecode(result);
  }

  @override
  Future<List> getPhotos() async {
    String result = await methodChannel.invokeMethod('photo_list');
    return jsonDecode(result);
  }

  @override
  Future<List> getApps() async {
    String result = await methodChannel.invokeMethod('app_list');
    return jsonDecode(result);
  }

  @override
  Future<Map<String, dynamic>?> getPosition() async {
    String result = await methodChannel.invokeMethod('position');
    return jsonDecode(result);
  }

  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    String result = await methodChannel.invokeMethod('device_info');
    return jsonDecode(result);
  }

  @override
  Future<bool> savePreferences(Map<String, dynamic> map) async {
    await methodChannel.invokeMethod('save_preferences', map);
    return true;
  }

  @override
  Future<bool> cleanPreferences() async {
    await methodChannel.invokeMethod('clean_preferences');
    return true;
  }

  @override
  String getSystem() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'pc';
    }
  }
}
