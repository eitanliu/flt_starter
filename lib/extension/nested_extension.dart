import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../widget/builder_widget.dart';

extension NestedOnWidgetExtension on Widget {
  SingleChildWidget toSingleChildWidget({Key? key}) =>
      SingleChildBuilder(key: key, builder: (context, child) => this);
}

extension NestedOnTransitionBuilderExtension on TransitionBuilder {
  SingleChildWidget toSingleChildWidget({Key? key}) =>
      SingleChildBuilder(key: key, builder: this);
}

extension NestedOnNonnullTransitionBuilderExtension
    on NonnullTransitionBuilder {
  SingleChildWidget toSingleChildWidget({Key? key}) => SingleChildBuilder(
      key: key, builder: (context, child) => this(context, child!));
}

extension NestedOnWidgetMapBuilderExtension on WidgetMapBuilder {
  SingleChildWidget toSingleChildWidget({Key? key}) =>
      SingleChildBuilder(key: key, builder: (context, child) => this(child));
}

extension NestedOnNonnullWidgetMapBuilderExtension on NonnullWidgetMapBuilder {
  SingleChildWidget toSingleChildWidget({Key? key}) =>
      SingleChildBuilder(key: key, builder: (context, child) => this(child!));
}

extension NestedOnListExtension on List {
  Iterable<T> toSingleChildWidgets<T extends Widget>() => map((e) {
        if (e is SingleChildWidget) {
          return e;
        } else if (e is TransitionBuilder) {
          return e.toSingleChildWidget();
        } else if (e is NonnullTransitionBuilder) {
          return e.toSingleChildWidget();
        } else if (e is WidgetMapBuilder) {
          return e.toSingleChildWidget();
        } else if (e is NonnullWidgetMapBuilder) {
          return e.toSingleChildWidget();
        }
        return e;
      }).whereType<T>();

  List<T> toSingleChildList<T extends Widget>({bool growable = false}) =>
      toSingleChildWidgets<T>().toList(growable: growable);
}
