import 'package:flutter_starter/extension.dart';
import 'package:flutter_starter/framework.dart';
import 'package:flutter_starter/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final AppBarProperties appBarProperties;
  final PreferredSizeWidget? bottom;
  final Size _preferredSize;

  AppBarWidget(
    BuildContext context,
    this.appBarProperties, {
    Key? key,
    Size? preferredSize,
    this.bottom,
  })  : _preferredSize =
            preferredSize ?? PreferredSizBuilder.getToolbarSize(context),
        super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => _preferredSize;
}

class _AppBarWidgetState extends State<AppBarWidget> {
  TextStyle? get titleTextStyle => context.appBarTheme.titleTextStyle;

  @override
  Widget build(BuildContext context) {
    AppBarProperties properties = widget.appBarProperties;
    return Observer(
      builder: (context) {
        return AppBar(
          systemOverlayStyle: properties.systemUiOverlayStyle.value,
          backgroundColor: _getAppBarBackground(properties),
          elevation: 0,
          centerTitle: properties.appBarTitleCenter.value,
          title: Text(
            properties.appBarTitle.value,
            style: TextStyle(
              fontSize: _getAppBarTitleSize(properties),
              color: _getAppBarTitleColor(properties),
              // fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
          leading: _getBackIconWidget(properties),
          actions: _getActionWidgets(properties),
          bottom: widget.bottom,
        );
      },
    );
  }

  ///
  /// 获取默认标题栏的字体颜色
  /// [property] 自定义属性信息
  ///
  /// 查找顺序->property->appbarTheme->DefaultTextStyle
  ///
  Color? _getAppBarTitleColor(AppBarProperties property) {
    if (property.appBarTitleColor.value != null) {
      return property.appBarTitleColor.value;
    }
    return titleTextStyle?.color;
  }

  ///
  /// 获取默认标题栏的字体大小
  /// [property] 自定义属性信息
  ///
  /// 查找顺序->property->appbarTheme->DefaultTextStyle
  ///
  double? _getAppBarTitleSize(AppBarProperties property) {
    if (property.appBarTitleSize.value != null) {
      return property.appBarTitleSize.value;
    }
    return titleTextStyle?.fontSize;
  }

  ///
  /// 获取默认标题栏颜色
  ///
  /// [property] 自定义属性信息
  ///
  /// 查找顺序->property->appbarTheme
  ///
  Color? _getAppBarBackground(AppBarProperties property) {
    if (property.appBarBgColor.value != null) {
      return property.appBarBgColor.value;
    }
    return context.theme.appBarTheme.backgroundColor;
  }

  ///
  /// 获取返回按钮信息
  ///
  Widget? _getBackIconWidget(AppBarProperties property) {
    if (property.appBarLeadingVisible.value == false) return null;
    return IconButton(
      onPressed: property.appBarLeadingCallback.value ??
          () {
            // context.pop();
            Navigator.of(context).let((nav) {
              if (nav.canPop()) nav.pop();
            });
          },
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: _getAppBarIconColor(property),
      ),
    );
  }

  ///
  /// 获取默认栏中的ICON的颜色
  ///
  /// [property] 自定义属性信息
  ///
  /// 查找顺序->property->appbarTheme(iconTheme)->Colors.white
  ///
  Color? _getAppBarIconColor(AppBarProperties property) {
    if (property.appBarLeadingColor.value != null) {
      return property.appBarLeadingColor.value;
    }
    if (context.theme.appBarTheme.iconTheme != null) {
      return context.theme.appBarTheme.iconTheme!.color;
    }
    return Colors.white;
  }

  ///
  /// 获取所有操作按钮
  ///
  List<Widget>? _getActionWidgets(AppBarProperties property) {
    if (property.actions.isEmpty) return null;
    int length = property.actions.length;
    return List.generate(
      length,
      (index) {
        IconInfo target = property.actions[index];
        return GestureDetector(
          onTap: () => target.onTap(target.index),
          child: target.showImage2Path
              ? Image.asset(
                  target.imagePath!,
                  width: 25,
                  height: 25,
                  color: target.color,
                )
              : Icon(
                  target.iconData!,
                  size: 25,
                  color: target.color,
                ),
        ).paddingRight(13);
      },
    );
  }
}
