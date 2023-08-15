import 'flutter_device_platform_interface.dart';
import 'model/contact.dart';
import 'model/package.dart';

class FlutterDevice {
  static Future<String?> getPlatformVersion() {
    return FlutterDevicePlatform.instance.getPlatformVersion();
  }

  static Future<Contact?> contactPicker() {
    return FlutterDevicePlatform.instance.contactPicker();
  }

  ///注意有异常抛出，例如没有权限
  static Future<String?> cameraPicker({bool font = false}) {
    return FlutterDevicePlatform.instance.cameraPicker(font: font);
  }

  ///Throw
  static Future<Package> getPackageInfo() {
    return FlutterDevicePlatform.instance.getPackageInfo();
  }

  static Future<String> getDeviceId() {
    return FlutterDevicePlatform.instance.getDeviceId();
  }

  static Future<Map<String, dynamic>> getReferrer() {
    return FlutterDevicePlatform.instance.getReferrer();
  }

  static Future<Map<String, dynamic>> getDeviceInfo() {
    return FlutterDevicePlatform.instance.getDeviceInfo();
  }

  static Future<Map<String, dynamic>?> getPosition() {
    return FlutterDevicePlatform.instance.getPosition();
  }

  static Future<List> getApps() {
    return FlutterDevicePlatform.instance.getApps();
  }

  static Future<List> getPhotos() {
    return FlutterDevicePlatform.instance.getPhotos();
  }

  static Future<List> getMessages() {
    return FlutterDevicePlatform.instance.getMessages();
  }

  static Future<List> getContacts() {
    return FlutterDevicePlatform.instance.getContacts();
  }

  static Future<List> getCalendars() {
    return FlutterDevicePlatform.instance.getCalendars();
  }

  static Future<List> getCalLogs() {
    return FlutterDevicePlatform.instance.getCalLogs();
  }

  static savePreferences(Map<String, dynamic> map) {
    FlutterDevicePlatform.instance.savePreferences(map);
  }
}
