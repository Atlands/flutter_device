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
  static Future<String?> cameraPicker() {
    return FlutterDevicePlatform.instance.cameraPicker();
  }

  static Future<Package> getPackageInfo() {
    return FlutterDevicePlatform.instance.getPackageInfo();
  }

  static Future<String> getDeviceId() {
    return FlutterDevicePlatform.instance.getDeviceId();
  }

  static Future<Map<String, dynamic>> getReferrer() {
    return FlutterDevicePlatform.instance.getReferrer();
  }
}
