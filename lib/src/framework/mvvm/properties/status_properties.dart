import 'package:flutter_starter/extension.dart';

mixin StatusProperties {
  /// 状态信息
  final status = StatusType.normal.toObs();

  /// 状态显示模式
  final statusModel = StatusModel.normalMask.toObs();

  /// 展示加载布局
  void showLoading() {
    status.value = StatusType.loading;
  }

  /// 展示正常布局
  void showNormal() {
    status.value = StatusType.normal;
  }

  /// 展示布局信息
  void dismissLoading() {
    status.value = StatusType.normal;
  }

  /// 展示空布局
  void showEmpty() {
    status.value = StatusType.empty;
  }

  /// 展示错误
  void showError() {
    status.value = StatusType.error;
  }
}

enum StatusModel {
  ///状态，默认盖在内容布局上方
  normalMask,

  ///状态，
  replaceMask,
}

enum StatusType {
  /// 状态，默认值
  normal,

  /// 状态，正在加载的时候
  loading,

  /// 状态，显示布局空页面
  empty,

  /// 状态，显示布局错误
  error,
}
