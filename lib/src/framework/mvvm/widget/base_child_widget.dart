import 'package:flutter_starter/framework/inject.dart';
import 'package:flutter/material.dart';
import 'package:view_model_provider/view_model_provider.dart';

import '../properties/status_properties.dart';
import '../viewmodel/base_viewmodel.dart';
import '../viewmodel/context_owner.dart';
import '../viewmodel/viewmodel_owner.dart';
import '../widget/base_status_widget.dart';
import 'base_viewmodel_widget.dart';
import 'dialog_viewmodel_mixin.dart';
import 'navigator_viewmodel_mixin.dart';

///
///  基础子页面创建
///
class BaseChildWidget<VM extends BaseViewModel>
    extends BaseViewModelWidget<VM> {
  final VM Function(BuildContext context)? create;

  final ViewModelWidgetCallback<VM>? initViewModel;

  final ViewModelWidgetCallback<VM>? initFrame;

  final ViewModelWidgetCallback<VM>? bindViewModel;

  final ViewModelWidgetCallback<VM>? disposeViewModel;

  final ViewModelWidgetChange<VM>? changeViewModel;

  final ViewModelWidgetBuilder<VM>? builder;

  const BaseChildWidget({
    Key? key,
    this.create,
    this.initViewModel,
    this.initFrame,
    this.bindViewModel,
    this.disposeViewModel,
    this.changeViewModel,
    Widget? child,
    this.builder,
  }) : super(key: key, child: child);

  @override
  State<BaseChildWidget> createState() => _BaseChildWidgetState<VM>();
}

class _BaseChildWidgetState<VM extends BaseViewModel>
    extends SingleChildState<BaseChildWidget<VM>>
    with
        ChildViewModelProviderMixin<VM>,
        ViewModelProviderLifecycle<VM>,
        ViewModelProviderBuilder<VM>,
        ViewModelOwnerMixin<VM>,
        ViewModelContextOwnerMixin<VM>,
        NavigatorOnViewModelMixin<VM>,
        DialogOnViewModelStateMixin<VM>
    implements ViewModelOwner<VM>, ContextOwner {
  @override
  VM create(BuildContext context) => widget.create?.call(context) ?? di<VM>();

  @override
  void initViewModel(BuildContext context, VM viewModel) {
    widget.initViewModel?.call(context, viewModel);
    super.initViewModel(context, viewModel);
  }

  @override
  void initFrame(BuildContext context, VM viewModel) {
    widget.initFrame?.call(context, viewModel);
    super.initFrame(context, viewModel);
  }

  @override
  void bindViewModel(BuildContext context, VM viewModel) {
    widget.bindViewModel?.call(context, viewModel);
    super.bindViewModel(context, viewModel);
  }

  @override
  void disposeViewModel(BuildContext context, VM viewModel) {
    super.disposeViewModel(context, viewModel);
    widget.disposeViewModel?.call(context, viewModel);
  }

  @override
  void changeViewModel(BuildContext context, VM viewModel, VM? oldViewModel) {
    widget.changeViewModel?.call(context, viewModel, oldViewModel);
    super.changeViewModel(context, viewModel, oldViewModel);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return buildProvider(context, child);
  }

  /// [buildProvider] 的参数 builder 为空时执行
  @override
  Widget buildChild(BuildContext context, VM viewModel, Widget? child) {
    Widget current;

    if (viewModel is StatusProperties) {
      current = BaseStatusWidget(
        viewModel as StatusProperties,
        builder: (context, value, child) {
          return buildContentWidget(context, viewModel, child);
        },
      );
    } else {
      current = buildContentWidget(context, viewModel, child);
    }

    return current;
  }

  ///
  ///  获取内容布局
  ///
  Widget buildContentWidget(BuildContext context, VM viewModel, Widget? child) {
    return widget.builder?.call(context, viewModel, child) ??
        child ??
        const SizedBox();
  }
}
