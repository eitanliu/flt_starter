class NumberUtils {
  NumberUtils._();

  static int? parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static int parseIntOrZero(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double? parseDouble(dynamic value) {
    if (value is double) return value;
    return double.tryParse(value.toString());
  }

  static double parseDoubleOrZero(dynamic value) {
    if (value is double) return value;
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
