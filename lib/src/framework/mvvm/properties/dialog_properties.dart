import 'package:flt_starter/foundation.dart';

mixin DialogProperties {
  ///
  ///  对话框的相关监听信息
  ///
  final dialog = UniqueValueNotifier<DialogProperty?>(null);

  ///
  /// 使用对话框
  ///
  void alertDialog(DialogProperty property) {
    dialog.value = property;
  }
}

class DialogProperty {
  ///
  /// 对话框标题信息
  ///
  final String title;

  ///
  /// 对话框内容信息
  ///
  final String content;

  ///
  /// 对话框最大高度
  ///
  final double maxHeight;

  ///
  /// 对话框确认文字
  ///
  final String confirmText;

  ///
  /// 对话框取消文字
  ///
  final String cancelText;

  ///
  /// 对话框是否可以返回
  ///
  final bool enableBack;

  ///
  /// 对话框确认回调
  ///
  final bool Function()? confirmClick;

  ///
  /// 对话框取消回调
  ///
  final bool Function()? cancelClick;

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
  DialogProperty(
    this.title,
    this.content, {
    this.maxHeight = 120,
    this.confirmText = "确定",
    this.cancelText = "取消",
    this.enableBack = true,
    this.confirmClick,
    this.cancelClick,
  });
}
