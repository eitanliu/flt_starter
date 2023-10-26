// import 'package:flt_starter/framework.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:view_model_provider/view_model_provider_mixin.dart';

import '../viewmodel/base_viewmodel.dart';

mixin GetItScopeLifecycleMixin<VM extends BaseViewModel>
    on ViewModelProviderLifecycle<VM> {
  String getScopeName(VM viewModel) =>
      "PageScope${describeIdentity(viewModel)}";

  ///
  /// GetIt 初始化
  ///
  void onGetItInit(GetIt scope) {}

  ///
  /// 创建ViewModel
  ///
  @override
  void initViewModel(BuildContext context, VM viewModel) {
    GetIt.I.pushNewScope(
      init: onGetItInit,
      scopeName: getScopeName(viewModel),
    );
    super.initViewModel(context, viewModel);
  }

  ///
  ///  销毁ViewModel的时候
  ///
  ///
  @override
  void disposeViewModel(BuildContext context, viewModel) {
    GetIt.I.dropScope(getScopeName(viewModel));
    super.disposeViewModel(context, viewModel);
  }
}
