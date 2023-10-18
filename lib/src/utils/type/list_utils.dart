class ListUtils {
  ListUtils._();

  /// 返回自身或空列表
  static List<E> orEmpty<E>(List<E>? list, {bool growable = false}) =>
      list ?? List<E>.empty(growable: growable);

  /// 删除空数据转为非空列表
  static List<E> castNotNull<E>(List<E?> list, {bool growable = true}) =>
      List<E>.of(
        list.where((element) => element != null).cast(),
        growable: growable,
      );
}
