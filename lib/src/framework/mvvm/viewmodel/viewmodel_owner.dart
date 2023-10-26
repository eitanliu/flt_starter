import 'package:flt_starter/extension/object_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:view_model_provider/view_model_provider_mixin.dart';

import 'base_viewmodel.dart';
import 'viewmodel_lifecycle.dart';

mixin ViewModelOwnerMixin<VM extends BaseViewModel>
    on ViewModelProviderLifecycle<VM> {
  late VM _viewModel;

  VM get viewModel => _viewModel;

  ViewModelLifecycle? get viewModelLifecycle => viewModel.asSafeType();

  @override
  void initViewModel(BuildContext context, viewModel) {
    _viewModel = viewModel;
    viewModelLifecycle?.initViewModel(context);
    super.initViewModel(context, viewModel);
  }

  @override
  void initFrame(BuildContext context, viewModel) {
    viewModelLifecycle?.initFrame(context);
    super.initFrame(context, viewModel);
  }

  @override
  void bindViewModel(BuildContext context, viewModel) {
    viewModelLifecycle?.bindViewModel(context);
    super.bindViewModel(context, viewModel);
  }

  @override
  void changeViewModel(BuildContext context, viewModel, oldViewModel) {
    _viewModel = viewModel;
    viewModelLifecycle?.changeViewModel(context);
    super.changeViewModel(context, viewModel, oldViewModel);
  }

  @override
  void disposeViewModel(BuildContext context, viewModel) {
    viewModelLifecycle?.disposeViewModel(context);
    super.disposeViewModel(context, viewModel);
  }
}

///
/// ViewModel的提供者
///
abstract class ViewModelOwner<VM> {
  ///
  /// 提供默认的ViewModel
  ///
  VM get viewModel;
}
