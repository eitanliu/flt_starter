import 'package:flutter_starter/framework/mvvm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../paging_data_source.dart';
import '../paging_footer_status.dart';
import '../paging_refresh_status.dart';

abstract class BasePagingViewModel<ITEM> extends BasePageViewModel {
  /// 首次刷新
  bool _firstRefresh = true;

  /// 分页信息
  late PagingDataSource<ITEM> _dataSource;

  /// 加载更多状态
  final ValueNotifier<FooterStatus> _footerStatus =
      ValueNotifier(FooterStatus.idle);

  /// 刷新状态
  final ValueNotifier<RefreshStatus> _refreshStatus =
      ValueNotifier(RefreshStatus.idle);

  /// 列表数据
  late ListNotifier<ITEM> _items;

  BasePagingViewModel() : super() {
    _dataSource = createDataSource();
    _items = _dataSource.getItems();
  }

  /// 刷新数据
  /// showDialog 是否显示弹窗，默认false，（当为false，且当前没有数据，则显示缺省进度）
  /// enableCancel 弹窗是否可返回键取消，取消后会退出页面
  void refresh({bool showDialog = false, bool enableCancel = false}) {
    if (_refreshStatus.value == RefreshStatus.refreshing) {
      return;
    }
    _firstRefresh = false;
    _refreshStatus.value = RefreshStatus.refreshing;

    ///todo 加载
    // if (!showDialog && isEmptyData()) {
    //   mState = EmptyState.PROGRESS;
    // }
    if (showDialog) {
      // showLoadingDialog(enableCancel:enableCancel);
      showLoading();
    }
    _dataSource.loadOnlineData(true);
  }

  void onReloadData() {
    refresh();
  }

  /// 加载更多
  void loadMore() {
    if (!enableLoadMore() ||
        _refreshStatus.value == RefreshStatus.refreshing ||
        _footerStatus.value == FooterStatus.loading ||
        _footerStatus.value == FooterStatus.noMore) {
      return;
    }
    _footerStatus.value = FooterStatus.loading;
    _dataSource.loadOnlineData(isEmptyData());
  }

  /// 加载结束的状态处理
  void finishLoad(bool error) {
    // showNormal();
    if (_dataSource.noMore() && !isEmptyData()) {
      _footerStatus.value = FooterStatus.noMore;
    } else {
      if (error &&
          (_footerStatus.value == FooterStatus.loading ||
              _footerStatus.value == FooterStatus.failed)) {
        _footerStatus.value = FooterStatus.failed;
      } else {
        _footerStatus.value = FooterStatus.idle;
      }
    }
    _refreshStatus.value = RefreshStatus.idle;
    if (isEmptyData()) {
      if (error) {
        showError();
      } else {
        showEmpty();
      }
    } else {
      showNormal();
    }
  }

  /// 创建分页数据
  PagingDataSource<ITEM> createDataSource();

  /// 判断是否是空数据的条件，可重写
  bool isEmptyData() {
    return _items.isEmpty;
  }

  /// 是否支持下拉刷新
  bool enableRefresh() {
    return true;
  }

  /// 是否支持加载更多
  bool enableLoadMore() {
    return true;
  }

  /// 距离底部多少item时，预加载下一页
  int preloadOffset() {
    return 2;
  }

  ListNotifier<ITEM> get items => _items;

  ValueNotifier<FooterStatus> get footerStatus => _footerStatus;

  ValueNotifier<RefreshStatus> get refreshStatus => _refreshStatus;

  bool get firstRefresh => _firstRefresh;
}
