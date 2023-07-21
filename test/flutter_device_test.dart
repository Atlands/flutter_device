import 'package:flutter_device/model/contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_device/flutter_device.dart';
import 'package:flutter_device/flutter_device_platform_interface.dart';
import 'package:flutter_device/flutter_device_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDevicePlatform
    with MockPlatformInterfaceMixin
    implements FlutterDevicePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> cameraPicker() {
    // TODO: implement cameraPicker
    throw UnimplementedError();
  }

  @override
  Future<Contact?> contactPicker() {
    // TODO: implement contactPicker
    throw UnimplementedError();
  }
}

void main() {
  final FlutterDevicePlatform initialPlatform = FlutterDevicePlatform.instance;

  test('$MethodChannelFlutterDevice is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDevice>());
  });

  test('getPlatformVersion', () async {
    FlutterDevice flutterDevicePlugin = FlutterDevice();
    MockFlutterDevicePlatform fakePlatform = MockFlutterDevicePlatform();
    FlutterDevicePlatform.instance = fakePlatform;

    expect(await FlutterDevice.getPlatformVersion(), '42');
  });
}
