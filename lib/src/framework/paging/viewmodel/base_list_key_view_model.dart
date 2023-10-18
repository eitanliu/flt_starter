import '../paging_data_source.dart';
import '../paging_key_data_source.dart';
import '../paging_loader.dart';
import '../viewmodel/base_paging_view_model.dart';

abstract class BaseListKeyViewModel<ITEM, KEY> extends BasePagingViewModel<ITEM>
    implements PagingKeyLoader<ITEM, KEY> {
  BaseListKeyViewModel(l) : super();

  @override
  PagingDataSource<ITEM> createDataSource() {
    return PageKeyDataSource(getFirstKey(), this, (error) {
      finishLoad(error);
    });
  }

  /// 第一页的KEY
  KEY? getFirstKey();
}
