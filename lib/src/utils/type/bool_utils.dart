class BoolUtils {
  BoolUtils._();

  static bool isTrue(bool? value) {
    return value == true;
  }

  static bool isFalse(bool? value) {
    return value == false;
  }

  static bool isNullOrTrue(bool? value) {
    return value != null ? value == true : true;
  }

  static bool isNullOrFalse(bool? value) {
    return value != null ? value == false : true;
  }
}
