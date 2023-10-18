import 'package:flutter/material.dart';

extension RadiusExtension on num {
  /// 扩展圆角计算
  Radius get radius => Radius.circular(toDouble());
}
