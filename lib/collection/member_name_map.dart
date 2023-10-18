import 'dart:collection';

class MemberNameMap<K extends String?, V>
    with MapMixin<K, V>
    implements Map<K, V> {
  static MemberNameMap<K, V> toMemberNameMap<K extends String?, V>(
    Map<K, V> map, {
    bool recursive = true,
  }) {
    MemberNameMap<K, V> current =
        map is MemberNameMap<K, V> ? map : MemberNameMap<K, V>(map);
    if (recursive) {
      current.forEach((key, value) {
        if (value is Map) {
          final now = convert(value, recursive: recursive);
          if (now != value) current[key] = now;
        } else if (value != null && value is List) {
          for (int i = 0; i < value.length; i++) {
            final iValue = value[i];
            if (iValue is Map) {
              final now = convert(iValue, recursive: recursive);
              if (now != iValue) value[i] = now;
            }
          }
        }
      });
    }
    return current;
  }

  static dynamic convert(dynamic value, {bool recursive = true}) {
    dynamic current = value;
    if (value is Map<String, String>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, String?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, String>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, String?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, int>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, int?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, int>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, int?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, double>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, double?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, double>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, double?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, bool>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, bool?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, bool>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, bool?>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String, dynamic>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is Map<String?, dynamic>) {
      current = toMemberNameMap(value, recursive: recursive);
    } else if (value is List) {
      current = convertList(value, recursive: recursive);
    }
    return current;
  }

  static List<E> convertList<E>(List<E> list, {bool recursive = true}) {
    for (int i = 0; i < list.length; i++) {
      final iValue = list[i];
      if (iValue is Map) {
        final now = convert(iValue, recursive: recursive);
        if (now != iValue) list[i] = now;
      }
    }
    return list;
  }

  late Map<K, V> _value;

  MemberNameMap([Map<K, V>? map]) : _value = map ?? HashMap();

  Map<K, V> getValue() => _value;

  setValue(Map<K, V> newValue) {
    _value = newValue;
  }

  @override
  V? operator [](Object? key) {
    return _value[key];
  }

  @override
  void operator []=(K key, V value) {
    _value[key] = value;
  }

  @override
  void clear() {
    _value.clear();
  }

  @override
  Iterable<K> get keys => _value.keys;

  @override
  V? remove(Object? key) {
    final result = _value.remove(key);
    return result;
  }

  static final _regSymbolName = RegExp(r'Symbol\(\"(.+)\"\)');

  @override
  noSuchMethod(Invocation invocation) {
    final memberName =
        _regSymbolName.firstMatch(invocation.memberName.toString())?.group(1);

    try {
      if (!invocation.isMethod && memberName != null) {
        if (invocation.isGetter) {
          return _value[memberName];
        } else if (invocation.isSetter) {
          String key = memberName.substring(0, memberName.length - 1);
          final value = invocation.positionalArguments
              .firstWhere((element) => true, orElse: () => null);

          return _value[key as K] = value;
        }
      }
    } catch (e) {
      return super.noSuchMethod(invocation);
    }
    return super.noSuchMethod(invocation);
  }
}
