import 'package:flutter/widgets.dart';
import 'package:view_model_provider/view_model_provider_mixin.dart';

import 'base_viewmodel.dart';
import 'viewmodel_lifecycle.dart';

mixin ContextOfOwner on ContextOwner {
  BuildContext get context => viewModelContext;
}

mixin ViewModelContextOwnerMixin<VM extends BaseViewModel>
    on ViewModelProviderLifecycle<VM> implements ContextOwner {
  late BuildContext _viewModelContext;

  @override
  BuildContext get viewModelContext => _viewModelContext;

  @override
  void initViewModel(BuildContext context, viewModel) {
    _viewModelContext = context;
    super.initViewModel(context, viewModel);
  }
}

///
/// [ContextOwner] 代理
///
mixin ContextOwnerDelegate implements ContextOwner {
  /// [ViewModelLifecycle.initViewModel] 会初始化代理
  late ContextOwner contextOwner;

  @override
  BuildContext get viewModelContext => contextOwner.viewModelContext;
}

///
/// [ContextOwner] 实现类
///
class _ContextOwnerImpl implements ContextOwner {
  @override
  BuildContext viewModelContext;

  _ContextOwnerImpl(this.viewModelContext);
}

///
/// [BuildContext] 的持有者
///
abstract interface class ContextOwner {
  factory ContextOwner.create(BuildContext context) =>
      _ContextOwnerImpl(context);

  BuildContext get viewModelContext;
}
