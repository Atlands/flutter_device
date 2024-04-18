// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_device/device_web.dart';
import 'package:flutter_device/fingerprintjs/fingerprintjs.dart';
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
      var geolocation = await html.window.navigator.geolocation
          .getCurrentPosition(
              enableHighAccuracy: true, timeout: const Duration(seconds: 3));
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
    var userAgent = html.window.navigator.userAgent;

    // var geolocation = await html.window.navigator.geolocation
    //     .getCurrentPosition(enableHighAccuracy: true);
    Map<String, dynamic>? position;
    try {
      position = await getPosition();
      // print(position);
    } catch (e) {
      // print(e);
    }

    var map = {
      'w': html.window.screen?.width ?? 0 * html.window.devicePixelRatio,
      'h': html.window.screen?.height ?? 0 * html.window.devicePixelRatio,
      'system': getSystem(),
      'latitude': position?['position_x'],
      'longitude': position?['position_y'],
      'hasOwnProperty': false,
      'appCodeName': html.window.navigator.appCodeName,
      'appName': html.window.navigator.appName,
      'appVersion': html.window.navigator.appVersion,
      'platform': html.window.navigator.platform,
      'userAgent': html.window.navigator.userAgent,
      'vendor': html.window.navigator.vendor,
      // "brands": DeviceWeb.judgeBrand(userAgent.toLowerCase()),
    };
    map.addAll(DeviceWeb.getInfo());
    return map;
  }

  @override
  Future<Map<String, dynamic>> getReferrer() async {
    var uri = Uri.dataFromString(html.window.location.href);
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
    // var visitorId = await Fingerprint.getHash();
    return getVisitorId();
  }

  @override
  Future<Package> getPackageInfo() async {
    try {
      final assets = await rootBundle.loadString('web/ver.json');
      final decodedAssets = json.decode(assets) as Map<String, dynamic>;
      return Package(
          appName: decodedAssets['app_name'] ?? '',
          packageName: decodedAssets['package_name'] ?? '',
          versionName: decodedAssets['version_name'] ?? '');
    } catch (_) {
      throw Exception("please created ver.json in web");
    }
  }

  @override
  String getSystem() {
    // var id = await getDeviceId();
    var system = 'pc';
    if (RegExp(r'(iPhone|iPad|iPod|iOS)')
        .hasMatch(html.window.navigator.userAgent)) {
      system = "ios";
    } else if (RegExp(r'(Android|Adr)')
        .hasMatch(html.window.navigator.userAgent)) {
      system = "android";
    } else {
      system = "pc";
    }
    return system;
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
