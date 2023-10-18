import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_starter_method_channel.dart';

abstract class FlutterStarterPlatform extends PlatformInterface {
  /// Constructs a FlutterStarterPlatform.
  FlutterStarterPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterStarterPlatform _instance = MethodChannelFlutterStarter();

  /// The default instance of [FlutterStarterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterStarter].
  static FlutterStarterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterStarterPlatform] when
  /// they register themselves.
  static set instance(FlutterStarterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
