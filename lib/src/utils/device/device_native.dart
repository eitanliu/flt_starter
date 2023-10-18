// ignore: implementation_imports
import 'package:pointycastle/src/platform_check/platform_check.dart';

import 'device.dart';
import 'device_sub.dart';

DeviceUtils createDevice() => DeviceUtilsNative();

class DeviceUtilsNative extends DeviceUtilsSub {
  @override
  String get platform => Platform.instance.platform;
}
