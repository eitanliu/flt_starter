import 'package:flutter/foundation.dart';

import '../src/foundation/async_print.dart';

void logcat(Object? object) {
  if (kDebugMode || LogcatConfig.logInRelease) {
    asyncPrint(object);
  }
}

class LogcatConfig {
  static bool logInRelease = false;
}
