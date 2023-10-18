import 'package:flutter_starter/flutter_starter.dart';
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

import '../viewmodel/base_paging_view_model.dart';
import 'paging_footer.dart';

/// 带有下拉刷新及上拉加载功能的ListView
/// 目前实现方式是禁用EasyRefresh的上拉加载功能，以插入item的形式实现上拉加载
class BaseGridView<VM extends BasePagingViewModel> extends StatefulWidget {
  /// 创建item
  final IndexedWidgetBuilder builder;

  final SliverGridDelegate gridDelegate;

  /// 进入自动刷新
  final bool firstRefresh;

  /// 下拉刷新样式
  final Header? header;

  /// 给底部加载的footer添加一个底部间距，只针对默认的footer有效(不包含footer本身高度64px)
  final double footerBottom;

  /// 自定义底部加载的footer
  final Footer? footer;

  @override
  State<BaseGridView> createState() {
    return _BaseGridViewState<VM>();
  }

  const BaseGridView({
    Key? key,
    required this.gridDelegate,
    required this.builder,
    this.firstRefresh = true,
    this.header,
    this.footer,
    this.footerBottom = 0,
  }) : super(key: key);
}

class _BaseGridViewState<VM extends BasePagingViewModel>
    extends State<BaseGridView> {
  final EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  late BasePagingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<VM>();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (widget.firstRefresh && _viewModel.firstRefresh) {
        _viewModel.refresh();
      }
    });
    _viewModel.refreshStatus.addListener(_refreshStatusListener);
  }

  /// 下拉刷新
  void _refreshStatusListener() {
    RefreshStatus status = _viewModel.refreshStatus.value;
    if (status == RefreshStatus.idle && _viewModel.enableRefresh()) {
      _easyRefreshController.finishRefresh(IndicatorResult.success);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.refreshStatus.removeListener(_refreshStatusListener);
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _easyRefreshController,
      refreshOnStart: false,
      header: widget.header ??
          const ClassicHeader(
            dragText: '下拉刷新',
            armedText: '释放刷新',
            readyText: '正在刷新',
            processingText: '正在刷新',
            processedText: '刷新完成',
            failedText: '刷新失败',
            noMoreText: '没有更多',
            messageText: '刷新时间%T',
            // showInfo: false,
          ),
      footer: widget.footer,
      onRefresh: _viewModel.enableRefresh()
          ? () async {
              if (!mounted) {
                return;
              }
              _viewModel.refresh();
            }
          : null,
      onLoad: _viewModel.enableLoadMore()
          ? () async {
              if (!mounted) {
                return;
              }
              _viewModel.loadMore();
            }
          : null,
      child: ListListenableBuilder<dynamic>(
        listenable: _viewModel.items,
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: widget.gridDelegate,
                delegate: SliverChildBuilderDelegate(
                  widget.builder,
                  childCount: _viewModel.items.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
