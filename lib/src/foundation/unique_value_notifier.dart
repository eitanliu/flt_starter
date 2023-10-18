import 'package:flutter/material.dart';

class UniqueValueNotifier<T> extends ValueNotifier<T> {
  UniqueValueNotifier(T value) : super(value);

  @override
  set value(T newValue) {
    if (value != newValue) {
      super.value = newValue;
    } else {
      notifyListeners();
    }
  }
}
