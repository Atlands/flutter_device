import 'flutter_device_platform_interface.dart';
import 'model/contact.dart';

class FlutterDevice {
  static Future<String?> getPlatformVersion() {
    return FlutterDevicePlatform.instance.getPlatformVersion();
  }

  static Future<Contact?> contactPicker() {
    return FlutterDevicePlatform.instance.contactPicker();
  }
}
