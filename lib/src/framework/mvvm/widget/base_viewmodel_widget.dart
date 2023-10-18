import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../viewmodel/base_viewmodel.dart';

///
/// 当ViewModel 创建完成之后
///
typedef DidViewModelCreated<VM> = Widget Function(
    BuildContext context, VM viewModel);

///
/// 封装一些创建widget的基础操作
///
abstract class BaseViewModelWidget<VM extends BaseViewModel>
    extends SingleChildStatefulWidget {
  ///
  /// [child] 需要渲染的布局信息
  ///
  const BaseViewModelWidget({
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);
}
