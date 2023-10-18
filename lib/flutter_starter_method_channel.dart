import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_starter_platform_interface.dart';

/// An implementation of [FlutterStarterPlatform] that uses method channels.
class MethodChannelFlutterStarter extends FlutterStarterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_starter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
