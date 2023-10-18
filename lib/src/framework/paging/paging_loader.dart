import 'paging_load_callback.dart';

/// 以页码进行分页的加载器
///
abstract class PagingIndexLoader<ITEM> {
  /// 加载数据
  /// pageIndex 要加载的页码，[PAGE_NUM_INIT]表示初始页码，即第一页
  /// loadCallback 加载结束回调，数据加载完，调用者需将数据回传（成功或失败）
  void loadData(int pageIndex, LoadCallback<ITEM> loadCallback);
}

/// 以key进行分页的加载器
///
abstract class PagingKeyLoader<ITEM, KEY> {
  /// 加载数据
  /// key 要加载的Key，Key == getFirstKey 表示刷新
  /// loadKeyCallback 加载结束回调，数据加载完，调用者需将数据回传（成功或失败）
  void loadData(KEY? key, LoadKeyCallback<ITEM, KEY> loadKeyCallback);
}
