import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'device.dart';

DeviceUtils createDevice() =>
    throw UnimplementedError("Device is Not Implemented in current platform");

abstract class DeviceUtilsSub implements DeviceUtils {
  @override
  EdgeInsets? padding;

  @override
  String get platform =>
      throw throw UnimplementedError("platform is Not Implemented");

  @override
  bool get isNative => !kIsWeb;
}
