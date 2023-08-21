import 'package:flutter_device/flutter_device.dart';
import 'package:flutter_device/flutter_device_method_channel.dart';
import 'package:flutter_device/flutter_device_platform_interface.dart';
import 'package:flutter_device/model/contact.dart';
import 'package:flutter_device/model/package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDevicePlatform
    with MockPlatformInterfaceMixin
    implements FlutterDevicePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<Contact?> contactPicker() {
    // TODO: implement contactPicker
    throw UnimplementedError();
  }

  @override
  Future<List> getApps() {
    // TODO: implement getApps
    throw UnimplementedError();
  }

  @override
  Future<List> getCalLogs() {
    // TODO: implement getCalLogs
    throw UnimplementedError();
  }

  @override
  Future<List> getCalendars() {
    // TODO: implement getCalendars
    throw UnimplementedError();
  }

  @override
  Future<List> getContacts() {
    // TODO: implement getContacts
    throw UnimplementedError();
  }

  @override
  Future<String> getDeviceId() {
    // TODO: implement getDeviceId
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getDeviceInfo() {
    // TODO: implement getDeviceInfo
    throw UnimplementedError();
  }

  @override
  Future<List> getMessages() {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<Package> getPackageInfo() {
    // TODO: implement getPackageInfo
    throw UnimplementedError();
  }

  @override
  Future<List> getPhotos() {
    // TODO: implement getPhotos
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getPosition() {
    // TODO: implement getPosition
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getReferrer() {
    // TODO: implement getReferrer
    throw UnimplementedError();
  }

  @override
  Future<bool> savePreferences(Map<String, dynamic> map) {
    // TODO: implement savePreferences
    throw UnimplementedError();
  }

  @override
  Future<String?> cameraPicker({bool font = false}) {
    // TODO: implement cameraPicker
    throw UnimplementedError();
  }

  @override
  Future<bool> cleanPreferences() {
    // TODO: implement cleanPreferences
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

  });
}
