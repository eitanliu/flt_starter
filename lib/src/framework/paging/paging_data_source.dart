import 'package:flt_starter/flt_starter.dart';

abstract class PagingDataSource<ITEM> {
  /// 获取可观测数据集合
  ListNotifier<ITEM> getItems();

  /// 加载数据
  /// refresh 是否是刷新
  void loadOnlineData(bool refresh);

  /// 是否无更多数据
  bool noMore();
}
