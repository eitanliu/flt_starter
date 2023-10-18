import 'dart:math';

import 'package:collection/collection.dart';

import '../foundation/logcat.dart';

class CacheList<E> extends DelegatingList<E> {
  var _cacheIndex = 0;
  var _cacheLength = 1000;

  int get cacheLength => _cacheLength;

  set cacheLength(int field) {
    if (_cacheIndex != 0) {
      final range = super.getRange(0, _cacheIndex).toList(growable: false);
      super.removeRange(0, _cacheIndex);
      super.addAll(range);
      _cacheIndex = 0;
    }
    if (super.length > field) {
      super.removeRange(0, super.length - field);
    }
    _cacheLength = field;
  }

  CacheList(List<E> base) : super(base);

  int _realIndex(int index) {
    return (index + _cacheIndex) % _cacheLength;
  }

  @override
  int get length {
    return min(super.length, _cacheLength);
  }

  @override
  void operator []=(int index, E value) {
    super[_realIndex(index)] = value;
  }

  @override
  E operator [](int index) {
    final value = super[_realIndex(index)];
    return value;
  }

  @override
  void add(E value) {
    final i = _realIndex(length);
    logcat("add ${super.length} $i, $_cacheIndex");
    if (i < super.length) {
      if (_cacheIndex >= _cacheLength) _cacheIndex = 0;
      _cacheIndex++;
      super[i] = value;
    } else {
      super.add(value);
    }
  }

  @override
  void addAll(Iterable<E> iterable) {}

  @override
  void insertAll(int index, Iterable<E> iterable) {}

  @override
  void insert(int index, E element) {}
}
