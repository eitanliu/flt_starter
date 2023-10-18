/// 以页码进行分页的数据加载回调
abstract class LoadCallback<ITEM> {
  /// 加载成功
  /// items 当次加载的数据集合
  /// pageIndex 当次加载的页码，一般由服务端返回，也可自己定义
  /// totalPages 总页数，一般由服务端返回
  /// total items 总数，一般由服务端返回
  void onSuccess(
    List<ITEM> items,
    int? pageIndex, {
    int? totalPages,
    int? total,
  });

  /// 加载失败
  void onFailure();
}

/// 以key进行分页的数据加载回调
///
/// Data: 3/12/21
abstract class LoadKeyCallback<ITEM, KEY> {
  /// 加载成功
  /// items 当次加载的数据集合
  /// currentKey 当前页的key，为getFirstKey表示当前为刷新
  /// nextKey 下一页的key，为空表示没有更多数据了
  /// hasMore 辅助字段，表示没有更多数据。不传的话使用nextKey判断是否有更多数据
  void onSuccess(List<ITEM> items, KEY? currentKey, KEY? nextKey,
      {bool? hasMore});

  /// 加载失败
  void onFailure();
}

abstract class DBLoadCallback<ITEM> {
  void onSuccess(List<ITEM> items);
}
