import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:view_model_provider/value_listenable_list_builder.dart';

extension ValueListenableExtension<T> on ValueListenable<T> {
  ValueListenableBuilder<T> listen(
    Widget Function(T value) builder, {
    Key? key,
  }) {
    return buildChild(key: key, (context, value, child) => builder(value));
  }

  ValueListenableBuilder<T> build(
    Widget Function(BuildContext context, T value) builder, {
    Key? key,
  }) {
    return buildChild(
      key: key,
      (context, value, child) => builder(context, value),
    );
  }

  ValueListenableBuilder<T> buildChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    Widget? child,
  }) {
    return ValueListenableBuilder<T>(
      key: key,
      valueListenable: this,
      builder: builder,
      child: child,
    );
  }

  SingleChildWidget buildSingleChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    Key? sKey,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => buildChild(builder, key: key, child: child),
    );
  }
}

extension ValueNotifierExtensin<T> on ValueNotifier<T> {}

extension NullableValueNotifierExtensin<T> on ValueNotifier<T?> {
  /// [value] 为空时调用 [ifAbsent] 进行初始化
  T getIfAbsent(T Function() ifAbsent) {
    return value ??= ifAbsent();
  }
}

extension ValueListenableListExtension<T> on List<ValueListenable<T>> {
  ValueListenableListBuilder<T> listen(
    Widget Function(List<T> value) builder, {
    Key? key,
  }) {
    return buildChild(key: key, (context, value, child) => builder(value));
  }

  ValueListenableListBuilder<T> build(
    Widget Function(BuildContext context, List<T> value) builder, {
    Key? key,
  }) {
    return buildChild(
      key: key,
      (context, value, child) => builder(context, value),
    );
  }

  ValueListenableListBuilder<T> buildChild(
    ValueListWidgetBuilder<T> builder, {
    Key? key,
    Widget? child,
  }) {
    return ValueListenableListBuilder(
      key: key,
      valueListenables: this,
      builder: builder,
      child: child,
    );
  }

  SingleChildWidget buildSingleChild(
    ValueListWidgetBuilder<T> builder, {
    Key? key,
    Key? sKey,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => buildChild(builder, key: key, child: child),
    );
  }
}
