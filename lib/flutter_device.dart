
import 'flutter_device_platform_interface.dart';

class FlutterDevice {
  Future<String?> getPlatformVersion() {
    return FlutterDevicePlatform.instance.getPlatformVersion();
  }
}
