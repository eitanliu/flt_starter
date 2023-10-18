import 'package:flutter/material.dart';

///
///  上下文扩展信息
///
extension BasicBuildContextExtension on BuildContext {
  bool nextFocus() {
    return FocusScope.of(this).nextFocus();
  }

  bool nextEditableTextFocus() {
    final scope = FocusScope.of(this);

    bool isEditableText() {
      final widget = scope.focusedChild?.context?.widget;
      return widget != null && widget is EditableText;
    }

    bool hasNextFocus() {
      final widget = scope.focusedChild?.context?.widget;
      return widget != null;
    }

    do {
      final successfully = FocusScope.of(this).nextFocus();
      if (!successfully && isEditableText()) return successfully;
    } while (hasNextFocus());
    return false;
  }
}
