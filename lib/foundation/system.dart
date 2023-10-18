import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 设置状态栏颜色
void initSystemStyle({
  Color? statusBarColor = Colors.transparent,
}) {
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
