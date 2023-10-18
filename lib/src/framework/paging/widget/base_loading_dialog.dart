/// 通用弹窗属性
///
class LoadingDialog {
  /// 是否显示，true表示显示弹窗，false表示关闭弹窗
  final bool showLoadingDialog;

  /// title(暂不支持)
  final String? title;

  /// 是否可关闭（安卓的虚拟返回键）
  final bool isCancelable;

  /// 是否可点击空白区域关闭(暂不支持)
  final bool isCancelOutside;

  const LoadingDialog({
    required this.showLoadingDialog,
    this.title,
    this.isCancelable = false,
    this.isCancelOutside = false,
  });
}
