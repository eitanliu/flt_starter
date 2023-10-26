import 'package:flt_starter/flt_starter.dart';

import 'paging_data_source.dart';
import 'paging_loader.dart';

/// 保存分页信息
///

class PageKeyDataSource<ITEM, KEY> extends PagingDataSource<ITEM>
    implements LoadKeyCallback<ITEM, KEY> {
  /// 可观测的数据源
  final ListNotifier<ITEM> _source = ListNotifier();

  /// 加载器
  late final PagingKeyLoader<ITEM, KEY> _dataLoader;

  /// 加载回调
  late final Function(bool error) _loadResult;

  /// 第一页KEY
  late final KEY _firstPageKey;

  /// 下一页KEY
  KEY? _nextPageKey;

  PageKeyDataSource(this._firstPageKey, this._dataLoader, this._loadResult);

  @override
  ListNotifier<ITEM> getItems() {
    return _source;
  }

  @override
  void loadOnlineData(bool refresh) {
    if (refresh) {
      _dataLoader.loadData(_firstPageKey, this);
    } else {
      /// 如果下一页的key为null，直接返回加载失败
      if (_nextPageKey == null) {
        _loadResult(false);
      } else {
        _dataLoader.loadData(_nextPageKey, this);
      }
    }
  }

  @override
  bool noMore() {
    return _nextPageKey == null;
  }

  @override
  void onFailure() {
    _loadResult(true);
  }

  @override
  void onSuccess(List<ITEM> items, KEY? currentKey, KEY? nextKey,
      {bool? hasMore}) {
    hasMore ??= nextKey != null;
    _nextPageKey = hasMore ? nextKey : null;
    if (currentKey != _firstPageKey) {
      _source.addAll(items);
    } else {
      _source.clear();
      _source.addAll(items);
    }
    _loadResult(false);
  }
}
