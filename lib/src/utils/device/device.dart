import 'package:flutter/widgets.dart';

import 'device_sub.dart'
    if (dart.library.io) 'device_native.dart'
    if (dart.library.js) 'device_web.dart';

abstract class DeviceUtils {
  factory DeviceUtils._() => createDevice();

  static final DeviceUtils instance = DeviceUtils._();

  EdgeInsets? padding;

  String get platform;

  bool get isNative;
}
