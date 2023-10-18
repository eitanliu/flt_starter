import '../collection/member_name_map.dart';

extension NullableListExtension<E> on List<E>? {
  /// 返回自身或空列表
  List<E> orEmptyList({bool growable = false}) =>
      this ?? List<E>.empty(growable: growable);
}

extension ListExtension<E> on List<E> {
  /// 删除空数据转为非空列表
  List<E> castNotNull({bool growable = true}) => List<E>.of(
        where((element) => element != null).cast(),
        growable: growable,
      );
}

extension ListGenericNullableExtension<E> on List<E?> {
  /// 删除空数据转为非空列表
  List<E> castNotNull({bool growable = true}) => List<E>.of(
        where((element) => element != null).cast(),
        growable: growable,
      );
}

extension StringMapNullableExtension<K extends String?, V> on Map<K, V> {
  MemberNameMap<K, V> toMemberNameMap({bool recursive = true}) =>
      MemberNameMap.toMemberNameMap<K, V>(this, recursive: recursive);
}
