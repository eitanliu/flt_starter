import 'package:flt_starter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:view_model_provider/pair_view_model_provider_mixin.dart';
import 'package:view_model_provider/view_model_provider_mixin.dart';

import '../properties/dialog_properties.dart';
import '../viewmodel/base_viewmodel.dart';
import '../viewmodel/context_owner.dart';
import '../viewmodel/viewmodel_owner.dart';

mixin DialogOnViewModelStateMixin<VM extends BaseViewModel>
    on ViewModelProviderLifecycle<VM>, ContextOwner, ViewModelOwner<VM> {
  @override
  void initViewModel(BuildContext context, viewModel) {
    viewModel.dialog.addListener(_dialogEvent);
    super.initViewModel(context, viewModel);
  }

  @override
  void disposeViewModel(BuildContext context, viewModel) {
    viewModel.dialog.removeListener(_dialogEvent);
    // viewModel.dialog.dispose();
    super.disposeViewModel(context, viewModel);
  }

  void _dialogEvent() {
    DialogProperty? property = viewModel.dialog.value;
    if (property != null) {
      DialogDash.showScrollViewDialog(
        viewModelContext,
        property.title,
        property.content,
        enableBack: property.enableBack,
        maxHeight: property.maxHeight,
        cancelText: property.cancelText,
        confirmText: property.confirmText,
        confirmClick: property.confirmClick,
        cancelClick: property.cancelClick,
      );
    }
  }
}

mixin DialogOnPairChildViewModelStateMixin<PVM extends BaseViewModel,
        VM extends BaseViewModel, T extends StatefulWidget>
    on PairViewModelProviderLifecycle<PVM, VM>, State<T> {
  late VM _viewModel;

  @override
  void initViewModel(BuildContext context, parent, viewModel) {
    _viewModel = viewModel;
    viewModel.dialog.addListener(_dialogEvent);
    super.initViewModel(context, parent, viewModel);
  }

  @override
  void disposeViewModel(BuildContext context, parent, viewModel) {
    viewModel.dialog.removeListener(_dialogEvent);
    viewModel.dialog.dispose();
    super.disposeViewModel(context, parent, viewModel);
  }

  @override
  void changeViewModel(BuildContext context, parent, viewModel, oldViewModel) {
    _viewModel = viewModel;
    oldViewModel?.dialog.removeListener(_dialogEvent);
    viewModel.dialog.addListener(_dialogEvent);
    super.changeViewModel(context, parent, viewModel, oldViewModel);
  }

  void _dialogEvent() {
    DialogProperty? property = _viewModel.dialog.value;
    if (property != null) {
      DialogDash.showScrollViewDialog(
        context,
        property.title,
        property.content,
        enableBack: property.enableBack,
        maxHeight: property.maxHeight,
        cancelText: property.cancelText,
        confirmText: property.confirmText,
        confirmClick: property.confirmClick,
        cancelClick: property.cancelClick,
      );
    }
  }
}
