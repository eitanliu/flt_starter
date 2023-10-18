import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class MapNotifier<K, V> extends ChangeNotifier
    implements Map<K, V>, ValueListenable<Map<K, V>> {
  Map<K, V> _value;

  MapNotifier([Map<K, V>? map]) : _value = map ?? HashMap();

  @override
  Map<K, V> get value => _value;

  set value(Map<K, V> newValue) {
    if (const DeepCollectionEquality().equals(_value, newValue)) return;
    _value = newValue;
    notifyListeners();
  }

  @override
  V? operator [](Object? key) {
    return _value[key];
  }

  @override
  void operator []=(K key, V value) {
    _value[key] = value;
    notifyListeners();
  }

  @override
  void addAll(Map<K, V> other) {
    _value.addAll(other);
    notifyListeners();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    _value.addEntries(newEntries);
    notifyListeners();
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return _value.cast<RK, RV>();
  }

  @override
  void clear() {
    _value.clear();
    notifyListeners();
  }

  @override
  bool containsKey(Object? key) {
    return _value.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return _value.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => _value.entries;

  @override
  void forEach(void Function(K key, V value) action) {
    _value.forEach(action);
  }

  @override
  bool get isEmpty => _value.isEmpty;

  @override
  bool get isNotEmpty => _value.isNotEmpty;

  @override
  Iterable<K> get keys => _value.keys;

  @override
  int get length => _value.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return _value.map(convert);
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    if (_value.containsKey(key)) {
      return _value[key] as V;
    }
    final result = _value[key] = ifAbsent();
    notifyListeners();
    return result;
  }

  @override
  V? remove(Object? key) {
    final result = _value.remove(key);
    notifyListeners();
    return result;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    _value.removeWhere(test);
    notifyListeners();
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    if (_value.containsKey(key)) {
      final result = _value[key] = update(_value[key] as V);
      notifyListeners();
      return result;
    }
    if (ifAbsent != null) {
      final result = _value[key] = ifAbsent();
      notifyListeners();
      return result;
    }
    throw ArgumentError.value(key, "key", "Key not in map.");
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    _value.updateAll(update);
    notifyListeners();
  }

  @override
  Iterable<V> get values => _value.values;
}
