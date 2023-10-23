import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../router/navigator_properties.dart';
import '../properties/dialog_properties.dart';

///
///  ViewModel基本的操作
///
abstract class BaseViewModel extends ChangeNotifier
    with DialogProperties
    implements NavigatorProperties {

  String pageIdentity() {
    return "$runtimeType-${identityHashCode(this)}";
  }
}
