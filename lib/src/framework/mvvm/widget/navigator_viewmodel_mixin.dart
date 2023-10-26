import 'package:flt_starter/framework/router.dart';
import 'package:flutter/material.dart';
import 'package:view_model_provider/view_model_provider_mixin.dart';

import '../viewmodel/base_viewmodel.dart';
import '../viewmodel/context_owner.dart';
import '../viewmodel/viewmodel_owner.dart';

mixin NavigatorOnViewModelMixin<VM extends BaseViewModel>
    on ViewModelProviderLifecycle<VM>
    implements ContextOwner, ViewModelOwner<VM> {
  @override
  void initViewModel(BuildContext context, viewModel) {
    viewModel.navigator.addListener(_navigatorEvent);
    super.initViewModel(context, viewModel);
  }

  @override
  void disposeViewModel(BuildContext context, viewModel) {
    viewModel.navigator.removeListener(_navigatorEvent);
    // viewModel.navigator.dispose();
    super.disposeViewModel(context, viewModel);
  }

  void _navigatorEvent() {
    NavigatorArgs? extra = viewModel.navigator.value;
    // if (extra != null) {
    //   if (extra.type == NavigatorType.navigatorTypePop) {
    //     viewModelContext.pop();
    //   } else {
    //     if (extra.path.isNotNullOrEmpty()) {
    //       if (extra.type == NavigatorType.navigatorTypePush) {
    //         viewModelContext.push(extra.path!, extra: extra.param);
    //       } else {
    //         viewModelContext.go(extra.path!, extra: extra.param);
    //       }
    //     }
    //   }
    // }
  }
}
