import 'package:flutter_device/model/package.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_device_method_channel.dart';
import 'model/contact.dart';

abstract class FlutterDevicePlatform extends PlatformInterface {
  /// Constructs a FlutterDevicePlatform.
  FlutterDevicePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDevicePlatform _instance = MethodChannelFlutterDevice();

  /// The default instance of [FlutterDevicePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDevice].
  static FlutterDevicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDevicePlatform] when
  /// they register themselves.
  static set instance(FlutterDevicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Contact?> contactPicker() {
    throw UnimplementedError('contactPicker() has not been implemented.');
  }

  Future<String?> cameraPicker({bool font = false}) {
    throw UnimplementedError('cameraPicker() has not been implemented.');
  }

  Future<Package> getPackageInfo() {
    throw UnimplementedError('getPackageInfo() has not been implemented.');
  }

  Future<String> getDeviceId() {
    throw UnimplementedError('getDeviceId() has not been implemented.');
  }

  Future<Map<String, dynamic>> getReferrer() {
    throw UnimplementedError('getReferrer() has not been implemented.');
  }

  Future<Map<String, dynamic>> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented.');
  }

  Future<Map<String, dynamic>?> getPosition() {
    throw UnimplementedError('getPosition() has not been implemented.');
  }

  Future<List> getApps() {
    throw UnimplementedError('getApps() has not been implemented.');
  }

  Future<List> getPhotos() {
    throw UnimplementedError('getPhotos() has not been implemented.');
  }

  Future<List> getMessages() {
    throw UnimplementedError('getMessages() has not been implemented.');
  }

  Future<List> getContacts() {
    throw UnimplementedError('getContacts() has not been implemented.');
  }

  Future<List> getCalendars() {
    throw UnimplementedError('getCalendars() has not been implemented.');
  }

  Future<List> getCalLogs() {
    throw UnimplementedError('getCalLogs() has not been implemented.');
  }

  Future<bool> savePreferences(Map<String,dynamic> map) {
    throw UnimplementedError('savePreferences() has not been implemented.');
  }
}
