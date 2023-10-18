import 'package:flutter_starter/extension.dart';
import 'package:flutter/material.dart';

class DialogDash {
  ///
  /// 对话框标题信息 [title]
  /// 对话框内容信息 [content]
  /// 对话框最大高度 [maxHeight]
  /// 对话框确认文字 [confirmText]
  /// 对话框取消文字 [cancelText]
  /// 对话框是否可以返回 [enableBack]
  /// 对话框确认回调 [confirmClick]
  /// 对话框取消回调 [cancelClick]
  ///
  static Future<T?> showScrollViewDialog<T>(
    BuildContext context,
    String title,
    String content, {
    double maxHeight = 120,
    String confirmText = "确定",
    String cancelText = "取消",
    bool enableBack = true,
    bool Function()? confirmClick,
    bool Function()? cancelClick,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          child: AlertDialog(
            title: Text(title, style: Theme.of(context).textTheme.bodyText1),
            content: getContentWidget(maxHeight, content),
            actions: <Widget>[
              getCancelBtn(cancelText, context, cancelClick),
              getConfirmBtn(confirmText, context, confirmClick),
            ],
          ),
          onWillPop: () => Future.value(enableBack),
        );
      },
    );
  }

  ///
  /// 获取内容信息
  ///
  static Container getContentWidget(double maxHeight, String content) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
    );
  }

  ///
  /// 获取对话框确定的布局信息
  ///
  static TextButton getConfirmBtn(
      String confirmText, BuildContext context, bool Function()? confirmClick) {
    return TextButton(
      child: Text(
        confirmText,
        style: TextStyle(color: context.theme.primaryColor),
      ),
      onPressed: () => _callFun(confirmClick, context),
    );
  }

  ///
  /// 获取对话框取消的相关属性
  ///
  static Widget getCancelBtn(
      String cancelText, BuildContext context, bool Function()? cancelClick) {
    return Visibility(
      visible: cancelText.isNotNullOrEmpty(),
      child: TextButton(
        child: Text(
          cancelText,
          style: TextStyle(color: context.theme.disabledColor),
        ),
        onPressed: () {
          if (cancelClick == null) {
            Navigator.of(context).pop();
          } else {
            _callFun(cancelClick, context);
          }
        },
      ),
    );
  }

  static void _callFun(bool Function()? fun, BuildContext context) {
    if (fun?.call() ?? false) {
      Navigator.of(context).pop();
    }
  }
}
