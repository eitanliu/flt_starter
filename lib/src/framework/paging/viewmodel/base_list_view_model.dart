import '../paging_data_source.dart';
import '../paging_index_data_source.dart';
import '../paging_loader.dart';
import 'base_paging_view_model.dart';

/// 以页码进行分页的ViewModel
abstract class BaseListViewModel<ITEM> extends BasePagingViewModel<ITEM>
    implements PagingIndexLoader<ITEM> {
  BaseListViewModel() : super();

  @override
  PagingDataSource<ITEM> createDataSource() {
    return PageIndexDataSource(this, (error) {
      finishLoad(error);
    });
  }
}
