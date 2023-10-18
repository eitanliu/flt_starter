import 'package:sprintf/sprintf.dart';

import 'standard_extension.dart';

extension NullableStringExtension on String? {
  /// 判断字符串空或null
  bool isNullOrEmpty() {
    return this?.isEmpty ?? true;
  }

  /// 判断字符串非空或非null
  bool isNotNullOrEmpty() {
    return this?.isNotEmpty ?? false;
  }

  String? takeNotEmpty() => this?.takeIf((it) => it.isNotEmpty);

  /// 判断字符串非空且大于0
  bool isNotNullOrGreaterZero() {
    return this != null && this!.isNotEmpty;
  }

  /// 返回自身或空字符串
  String orEmptyString() => this ?? '';
}

extension StringExtension on String {
  /// 格式化字符串
  String format(List<dynamic> args) => sprintf(this, args);
}
