import 'package:flt_starter/framework/router.dart';

import '../properties/appbar_properties.dart';
import '../properties/status_properties.dart';
import 'base_viewmodel.dart';
import 'context_owner.dart';
import 'viewmodel_lifecycle.dart';

abstract class BasePageViewModel extends BaseViewModel
    with
        ContextOwnerDelegate,
        ContextOfOwner,
        ViewModelLifecycle,
        NavigatorProperties,
        AppBarProperties,
        StatusProperties {}
