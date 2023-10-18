import 'dart:math';

import 'package:flutter_starter/flutter_starter.dart';

import 'paging_data_source.dart';
import 'paging_loader.dart';

/// 初始页面
const int _sPageNumInit = 1;

/// 保存页码分页信息

class PageIndexDataSource<ITEM> extends PagingDataSource<ITEM>
    implements LoadCallback<ITEM> {
  /// 可观测的数据源
  final ListNotifier<ITEM> _source = ListNotifier();

  /// 加载器
  final PagingIndexLoader<ITEM> _dataLoader;

  /// 加载回调
  final Function(bool error) _loadResult;

  /// 下一页页码
  int _nextPageIndex = _sPageNumInit;

  /// 总页数
  int? _totalPages;

  /// 总数
  int? _total;

  PageIndexDataSource(this._dataLoader, this._loadResult);

  @override
  ListNotifier<ITEM> getItems() {
    return _source;
  }

  @override
  void loadOnlineData(bool refresh) {
    if (refresh) {
      _dataLoader.loadData(_sPageNumInit, this);
    } else {
      _dataLoader.loadData(max(_nextPageIndex, _sPageNumInit + 1), this);
    }
  }

  @override
  bool noMore() {
    int? totalPages = _totalPages;
    int? total = _total;
    if (totalPages != null) {
      return _nextPageIndex > totalPages;
    } else if (total != null) {
      return _source.length >= total;
    }
    return true;
  }

  @override
  void onFailure() {
    _loadResult(true);
  }

  @override
  void onSuccess(
    List<ITEM> items,
    int? pageIndex, {
    int? totalPages,
    int? total,
  }) {
    _nextPageIndex = pageIndex == null ? _sPageNumInit : (pageIndex + 1);
    _totalPages = totalPages;
    _total = total;
    if (pageIndex != null && pageIndex > _sPageNumInit) {
      _source.addAll(items);
    } else {
      _source.value.clear();
      _source.addAll(items);
    }
    _loadResult(false);
  }
}
