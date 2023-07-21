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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Contact?> contactPicker(){
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> cameraPicker(){
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
