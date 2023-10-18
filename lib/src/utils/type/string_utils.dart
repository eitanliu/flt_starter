class StringUtils {
  StringUtils._();

  /// 判断字符串空或null
  static bool isNullOrEmpty(String? str) {
    return str?.isEmpty ?? true;
  }

  /// 判断字符串非空或非null
  static bool isNotNullOrEmpty(String? str) {
    return str?.isNotEmpty ?? false;
  }

  static String orEmpty(String? str) {
    return str ?? "";
  }

  static String toStringOrEmpty(dynamic object) {
    return object?.toString() ?? "";
  }

  static String? toStringOrNull(dynamic object) {
    return object?.toString();
  }

  static String? asString(dynamic object) {
    return object is String? ? object : null;
  }

  static String? asNotEmptyString(dynamic object) {
    return object is String ? (object.isEmpty ? null : object) : null;
  }
}
