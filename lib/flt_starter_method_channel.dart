import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flt_starter_platform_interface.dart';

/// An implementation of [FltStarterPlatform] that uses method channels.
class MethodChannelFltStarter extends FltStarterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flt_starter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
