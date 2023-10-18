import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx/mobx.dart' as m;
import 'package:nested/nested.dart';

EqualityComparer<T>? _uniqueCompare<T>(bool unique) {
  return unique ? (p0, p1) => false : null;
}

//// 可监听数据扩展 ////

// ignore: prefer_void_to_null
extension ObservableOnNullExtension on Null {
  /// turns a bool into Observable<bool>
  Observable<T?> toObs<T>({
    String? name,
    ReactiveContext? context,
    EqualityComparer<T>? equals,
    bool unique = false,
  }) {
    return Observable(
      null,
      name: name,
      context: context,
      equals: equals ?? _uniqueCompare(unique),
    );
  }
}

extension ObservableOnBoolExtension<T extends bool?> on T {
  /// turns a bool into Observable<bool>
  Observable<T> toObs({
    String? name,
    ReactiveContext? context,
    EqualityComparer<T>? equals,
    bool unique = false,
  }) {
    return Observable(
      this,
      name: name,
      context: context,
      equals: equals ?? _uniqueCompare(unique),
    );
  }
}

extension ObservableOnNumExtension<T extends num?> on T {
  /// turns an int into ObservableValue<T extends num>
  Observable<T> toObs({
    String? name,
    ReactiveContext? context,
    EqualityComparer<T>? equals,
    bool unique = false,
  }) {
    return Observable(
      this,
      name: name,
      context: context,
      equals: equals ?? _uniqueCompare(unique),
    );
  }
}

extension ObservableOnComparableExtension<T extends Comparable?> on T {
  /// turns an int into ObservableValue<T extends Comparable>
  Observable<T> toObs({
    String? name,
    ReactiveContext? context,
    EqualityComparer<T>? equals,
    bool unique = false,
  }) {
    return Observable(
      this,
      name: name,
      context: context,
      equals: equals ?? _uniqueCompare(unique),
    );
  }
}

extension ObservableOnEnumExtension<T extends Enum?> on T {
  /// turns a String into Observable<T extends Enum>
  Observable<T> toObs({
    String? name,
    ReactiveContext? context,
    EqualityComparer<T>? equals,
    bool unique = false,
  }) {
    return Observable(
      this,
      name: name,
      context: context,
      equals: equals ?? _uniqueCompare(unique),
    );
  }
}

extension ObservableOnStreamExtension<T> on Stream<T> {
  /// turn a Stream into ObservableStream.
  ObservableStream<T> toObs({
    T? initialValue,
    bool cancelOnError = false,
    ReactiveContext? context,
    String? name,
  }) =>
      ObservableStream<T>(
        this,
        initialValue: initialValue,
        cancelOnError: cancelOnError,
        context: context,
        name: name,
      );
}

extension ObservableOnFutureExtension<T> on Future<T> {
  /// turn a Future into ObservableFuture.
  ObservableFuture<T> toObs({ReactiveContext? context, String? name}) =>
      ObservableFuture<T>(this, context: context, name: name);
}

extension ObservableOnListExtension<T> on List<T> {
  /// turn a List into ObservableFuture.
  ObservableList<T> toObs({ReactiveContext? context, String? name}) =>
      ObservableList<T>.of(this, context: context, name: name);
}

extension ObservableOnSetExtension<T> on Set<T> {
  /// turn a Set into ObservableFuture.
  ObservableSet<T> toObs({ReactiveContext? context, String? name}) =>
      ObservableSet<T>.of(this, context: context, name: name);
}

extension ObservableOnMapExtension<K, V> on Map<K, V> {
  /// turn a Map into ObservableFuture.
  ObservableMap<K, V> toObs({ReactiveContext? context, String? name}) =>
      ObservableMap<K, V>.of(this, context: context, name: name);
}

extension ObservableBoolExtension on Observable<bool> {
  /// lets you toggle the internal value of ObservableBool
  void toggle() {
    runInAction(() => value = !value);
  }
}

extension NullableObservableExtensin<T> on Observable<T?> {
  /// [value] 为空时调用 [ifAbsent] 进行初始化
  T getIfAbsent(T Function() ifAbsent) {
    return value ??= ifAbsent();
  }
}

//// 监听函数扩展 ////

extension ObservableOnFuncReactionExtension on Function(Reaction) {
  ReactionDisposer autorun(
    void Function() effect, {
    String? name,
    int? delay,
    ReactiveContext? context,
    void Function(Object, Reaction)? onError,
  }) {
    return m.autorun(
      this,
      name: name,
      delay: delay,
      context: context,
      onError: onError,
    );
  }
}

extension ObservableOnTypeFuncReactionExtension<T> on T Function(Reaction) {
  ReactionDisposer autorun(
    void Function() effect, {
    String? name,
    int? delay,
    ReactiveContext? context,
    void Function(Object, Reaction)? onError,
  }) {
    return m.autorun(
      this,
      name: name,
      delay: delay,
      context: context,
      onError: onError,
    );
  }

  ReactionDisposer reaction(
    void Function(T) effect, {
    String? name,
    int? delay,
    bool? fireImmediately,
    EqualityComparer<T>? equals,
    ReactiveContext? context,
    void Function(Object, Reaction)? onError,
  }) {
    return m.reaction<T>(
      this,
      effect,
      name: name,
      delay: delay,
      fireImmediately: fireImmediately,
      equals: equals,
      context: context,
      onError: onError,
    );
  }
}

extension ObservableOnBoolFunReactionExtension on bool Function(Reaction) {
  ReactionDisposer when(
    void Function() effect, {
    String? name,
    ReactiveContext? context,
    int? timeout,
    void Function(Object, Reaction)? onError,
  }) {
    return m.when(
      this,
      effect,
      name: name,
      context: context,
      timeout: timeout,
      onError: onError,
    );
  }

  Future<void> asyncWhen(
    bool Function(Reaction) predicate, {
    String? name,
    int? timeout,
    ReactiveContext? context,
  }) {
    return m.asyncWhen(this, name: name, timeout: timeout, context: context);
  }
}
