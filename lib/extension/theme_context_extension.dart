import 'package:flutter/material.dart';

///
///  上下文扩展信息
///
extension ThemeContextExtension on BuildContext {
  /// 获取主题信息
  ThemeData get theme => Theme.of(this);

  /// 获取主题颜色
  Color get primaryColor => theme.primaryColor;

  /// 获取禁用颜色
  Color get disabledColor => theme.disabledColor;

  /// 获取标题栏主题
  AppBarTheme get appBarTheme => theme.appBarTheme;

  /// 标题颜色
  TextStyle? get titleTextStyle => appBarTheme.titleTextStyle;

  /// 获取文本主题
  TextTheme get textTheme => theme.textTheme;

  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;

  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;
}
