import 'package:flutter/widgets.dart';

import 'context_owner.dart';

mixin ViewModelLifecycle {
  void initViewModel(BuildContext context) {
    if (this is ContextOwnerDelegate) {
      final delegate = this as ContextOwnerDelegate;
      delegate.contextOwner = ContextOwner.create(context);
    }
  }

  void initFrame(BuildContext context) {}

  void bindViewModel(BuildContext context) {}

  void changeViewModel(BuildContext context) {
    if (this is ContextOwnerDelegate) {
      final delegate = this as ContextOwnerDelegate;
      if (delegate.viewModelContext != context) {
        delegate.contextOwner = ContextOwner.create(context);
      }
    }
  }

  void disposeViewModel(BuildContext context) {}
}
