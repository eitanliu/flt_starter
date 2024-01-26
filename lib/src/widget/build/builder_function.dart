import 'package:flutter/widgets.dart';

export 'package:flutter/widgets.dart'
    show
        WidgetBuilder,
        ValueWidgetBuilder,
        TransitionBuilder,
        IndexedWidgetBuilder,
        NullableIndexedWidgetBuilder;

/// 创建可空 Widget
typedef NullableWidgetBuilder = Widget? Function(BuildContext context);

/// Value 创建可空 Widget
typedef NullableValueWidgetBuilder<T> = Widget? Function(
    BuildContext context, T value, Widget? child);

/// 非空 Widget -> 非空 Widget
typedef NonnullWidgetConvertBuilder = Widget Function(Widget child);

/// 可空 Widget -> 非空 Widget
typedef WidgetConvertBuilder = Widget Function(Widget? child);

/// 可空 Widget -> 可空 Widget
typedef NullableWidgetMapBuilder = Widget? Function(Widget? child);

/// 非空 Widget -> 非空 Widget
typedef NonnullTransitionBuilder = Widget Function(
    BuildContext context, Widget child);

/// 可空 Widget -> 可空 Widget
typedef NullableTransitionBuilder = Widget? Function(
    BuildContext context, Widget? child);

typedef ValueTransitionBuilder<T> = Widget Function(
    BuildContext context, T value);

typedef NullableValueTransitionBuilder<T> = Widget? Function(
    BuildContext context, T value);
