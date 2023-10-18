import 'package:flutter_starter/extension.dart';
import 'package:flutter_starter/src/widget/builder_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nested/nested.dart';

import '../properties/status_properties.dart';

class BaseStatusWidget<VM extends StatusProperties>
    extends SingleChildStatelessWidget {
  final VM viewModel;
  final bool? expand;
  final NullableValueWidgetBuilder<VM>? builder;

  const BaseStatusWidget(
    this.viewModel, {
    Key? key,
    this.expand,
    this.builder,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Observer(
      builder: (context) {
        final status = viewModel.status.value;
        return Nested(
          children: [
            if (expand == true && status != StatusType.normal)
              SingleChildBuilder(
                builder: (context, child) => SizedBox.expand(
                  child: child,
                ),
              ),
            SingleChildBuilder(
              builder: (context, child) => getStatusContent(context, child),
            )
          ],
          child: child,
        );
      },
    );
  }

  ///
  /// 获取布局状态
  ///
  Widget getStatusContent(BuildContext context, Widget? child) {
    final state = viewModel.status.value;
    if (state == StatusType.empty) {
      return getEmptyWidget(context);
    } else if (state == StatusType.loading) {
      return getLoadingIndicator();
    } else if (state == StatusType.error) {
      return getErrorWidget(context);
    } else {
      return builder?.call(context, viewModel, child) ??
          child ??
          const SizedBox();
    }
  }

  ///
  /// 获取空布局信息
  ///
  Widget getErrorWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Image(
        //   image: AssetImage(Assets.imagesIcEmpty, package: "base"),
        // ),
        Text(
          "加载失败请稍后重试～",
          style: context.bodyMedium,
        ).paddingTop(20),
      ],
    );
  }

  ///
  /// 获取空布局信息
  ///
  Widget getEmptyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Image(
        //   image: AssetImage(Assets.imagesIcEmpty, package: "base"),
        // ),
        Text(
          "暂无内容～",
          style: context.bodyMedium,
        ).paddingTop(20),
      ],
    );
  }

  ///
  /// 获取加载框样式
  ///
  Widget getLoadingIndicator() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const CupertinoActivityIndicator(radius: 14, color: Colors.white),
    );
  }

  ///
  /// 根据状态获取当前的背景颜色
  ///
  ///
  Color? _getStatusColor(BuildContext context) {
    if (viewModel.statusModel.value == StatusModel.normalMask) {
      return Colors.transparent;
    } else {
      return Theme.of(context).colorScheme.background;
    }
  }
}
