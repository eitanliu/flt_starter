import 'package:flutter_starter/foundation.dart';

///
/// 导航代理
///
abstract class NavigatorDelegate implements NavigatorProperties {
  NavigatorProperties get navigatorDelegate;

  @override
  void go(String path, {Object? param}) =>
      navigatorDelegate.go(path, param: param);

  @override
  UniqueValueNotifier<NavigatorArgs?> get navigator =>
      navigatorDelegate.navigator;

  @override
  void pop() => navigatorDelegate.pop();

  @override
  void push(String path, {Object? param}) =>
      navigatorDelegate.push(path, param: param);
}

///
/// 导航栏相关属性
///
mixin NavigatorProperties {
  final navigator = UniqueValueNotifier<NavigatorArgs?>(null);

  void push(String path, {Object? param}) {
    navigator.value = NavigatorArgs(
      NavigatorType.push,
      path: path,
      param: param,
    );
  }

  void pop() {
    navigator.value = NavigatorArgs(
      NavigatorType.pop,
    );
  }

  void go(String path, {Object? param}) {
    navigator.value = NavigatorArgs(
      NavigatorType.go,
      path: path,
      param: param,
    );
  }
}

/// 路由携带参数
class NavigatorArgs {
  final NavigatorType type;
  String? path;
  Object? param;

  NavigatorArgs(this.type, {this.path, this.param});
}

enum NavigatorType {
  pop,
  push,
  go,
}
