import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../router/navigator_properties.dart';
import '../properties/dialog_properties.dart';

///
///  ViewModel基本的操作
///
abstract class BaseViewModel extends ChangeNotifier
    with DialogProperties
    implements NavigatorProperties {
  String basicPageViewModel = "";

  String pageRandom() {
    if (basicPageViewModel.isEmpty) {
      basicPageViewModel = const Uuid().v4().replaceAll("-", "");
      basicPageViewModel =
          "$basicPageViewModel--${DateTime.now().microsecondsSinceEpoch}--${Random().nextDouble()}";
    }
    return "$runtimeType-$basicPageViewModel";
  }
}
