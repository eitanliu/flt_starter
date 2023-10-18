import 'dart:async';

import 'package:flutter_starter/extension/response_extension.dart';
import 'package:dio/dio.dart';

import 'logcat.dart';
import 'toast.dart';

///
/// 全局异常处里函数
/// [computation] 执行内容
/// [onError] 执行错误后的回调
/// [toastNetError] 是否需要toast网络错误
///
Future<T> launch<T>(
  FutureOr<T> Function() computation, {
  Function(Object? error)? onError = _ignoreError,
  bool toastNetError = true,
  bool trace = true,
}) {
  return Future<T>(computation).onError((error, stackTrace) {
    if (trace) logcat(stackTrace.toString());

    ///处理网络异常信息
    if (toastNetError) {
      if (error is DioException) {
        DioException data = error;
        String? info = data.response.checkException();
        toast(info);
      }
      if (error is String) {
        toast(error.toString());
      }
    }
    if (onError == null) throw error ?? ArgumentError.notNull('error');
    return onError(error);
  });
}

void _ignoreError(Object? error) {}
