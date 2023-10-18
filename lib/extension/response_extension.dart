import 'package:dio/dio.dart';

import 'standard_extension.dart';

extension ResponseExtension on Response? {
  String? checkException() {
    String? result = this?.let((value) {
      if (value.statusCode == 401) {
        return null;
      } else if (value.statusCode != 200) {
        return "服务器出错啦～[${value.statusCode}]";
      }
      return "客户端出现未知错误～";
    });
    return result;
  }
}
