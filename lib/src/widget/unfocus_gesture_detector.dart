import 'package:flutter_starter/extension/object_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

enum UnFocusBehavior {
  onPanDown,
  onTapDown,
}

class UnFocusGestureDetector extends SingleChildStatelessWidget {
  /// 默认忽略[TextField]和为[Focus.debugLabel] 为`IgnoreUnFocus`
  static const List<String> defaultIgnoreLabels = [
    "EditableText",
    "IgnoreUnFocus"
  ];

  final UnFocusBehavior behavior;

  /// [Focus.debugLabel] 名称相同不取消焦点
  /// 默认忽略[TextField]和为[Focus.debugLabel] 为`IgnoreUnFocus`
  final List<String> ignoreLabels;
  final FocusScopeNode? currentFocus;

  const UnFocusGestureDetector({
    Key? key,
    Widget? child,
    this.behavior = UnFocusBehavior.onPanDown,
    this.ignoreLabels = defaultIgnoreLabels,
    this.currentFocus,
  }) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GestureDetector(
      // behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onPanDown: _onPanDown,
      child: child,
    );
  }

  get _onTapDown =>
      behavior == UnFocusBehavior.onTapDown ? _unfocusTapDown : null;

  get _onPanDown =>
      behavior == UnFocusBehavior.onPanDown ? _unfocusDragDown : null;

  void _unfocusTapDown(TapDownDetails details) {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // logcat("currentFocus $currentFocus");
    unfocusPosition(
      details.globalPosition,
      ignoreLabels: ignoreLabels,
      currentFocus: currentFocus,
    );
  }

  void _unfocusDragDown(DragDownDetails details) {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // logcat("currentFocus $currentFocus");
    unfocusPosition(
      details.globalPosition,
      ignoreLabels: ignoreLabels,
      currentFocus: currentFocus,
    );
  }

  static unfocusTapDown(
    TapDownDetails details, {
    List<String> ignoreLabels = defaultIgnoreLabels,
    FocusScopeNode? currentFocus,
  }) {
    unfocusPosition(
      details.globalPosition,
      ignoreLabels: ignoreLabels,
      currentFocus: currentFocus,
    );
  }

  static unfocusDragDown(
    DragDownDetails details, {
    List<String> ignoreLabels = defaultIgnoreLabels,
    FocusScopeNode? currentFocus,
  }) {
    unfocusPosition(
      details.globalPosition,
      ignoreLabels: ignoreLabels,
      currentFocus: currentFocus,
    );
  }

  static unfocusPosition(
    Offset globalPosition, {
    List<String> ignoreLabels = defaultIgnoreLabels,
    FocusScopeNode? currentFocus,
  }) {
    final primaryFocus =
        currentFocus?.focusedChild ?? FocusManager.instance.primaryFocus;
    final nearestScope = primaryFocus?.nearestScope;
    // logcat("primaryFocus $primaryFocus");
    // logcat("nearestScope $nearestScope");

    final descendants = nearestScope?.traversalDescendants;
    final editableTexts = descendants?.where((element) => ignoreLabels
        .contains(element.context?.widget.asSafeType<Focus>()?.debugLabel));
    final rects = editableTexts?.map((e) => e.rect);
    final inEditableText = rects?.any((element) {
          // logcat("EditableText $element, ${details.globalPosition}");
          return element.contains(globalPosition);
        }) ??
        false;
    // logcat("inEditableText $inEditableText");

    if (inEditableText) {
      return;
    }
    final isEditableText = ignoreLabels.contains(
        primaryFocus?.context?.widget.asSafeType<Focus>()?.debugLabel);
    // logcat("isEditableText $isEditableText");

    if (isEditableText) {
      primaryFocus?.unfocus();
    }
  }

  static ignoreUnFocus(Widget child) => Focus(
        debugLabel: "IgnoreUnFocus",
        child: child,
      );
}
