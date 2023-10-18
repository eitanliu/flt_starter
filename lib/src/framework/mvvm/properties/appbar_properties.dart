import 'package:flutter_starter/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// appBar相关配置信息
mixin AppBarProperties {
  ///设置appBar模式->黑暗模式和白天模式
  final systemUiOverlayStyle = null.toObs<SystemUiOverlayStyle>();

  /// 是否展示appBar
  final appBarVisible = true.toObs();

  /// 设置appBar背景颜色
  final appBarBgColor = null.toObs<Color>();

  /// 标题栏
  final appBarTitle = "".toObs();

  /// 设置标题字体大小
  final appBarTitleSize = null.toObs<double>();

  /// 设置中间标题栏颜色
  final appBarTitleColor = null.toObs<Color>();

  /// 标题是否居中显示
  final appBarTitleCenter = true.toObs();

  /// 是否展示appBar返回按钮
  final appBarLeadingVisible = true.toObs();

  /// 是否appBar返回按钮颜色
  final appBarLeadingColor = null.toObs<Color>();

  /// 左边按钮回调
  final appBarLeadingCallback = null.toObs<VoidCallback>();

  final appActionSize = 0.0.toObs();

  final actions = <IconInfo>[].toObs();
}

/// Desc:
/// <p>  设置右边的颜色
/// Date: 5/20/21
/// Copyright: Copyright (c) 2010-2021
/// Updater:
/// Update Time:
/// Update Comments:
///
///
class IconInfo {
  ///
  /// 当前角标
  ///
  int index;

  /// 图片路径
  String? imagePath;

  /// 系统图标
  IconData? iconData;

  /// 展示系统图标
  bool showImage2Path;

  ///
  /// 默认颜色
  ///
  Color? color;

  ///
  /// 回调方法
  ///
  Function(int) onTap;

  IconInfo(
    this.index,
    this.onTap,
    this.showImage2Path, {
    this.imagePath,
    this.iconData,
    this.color,
  });
}
