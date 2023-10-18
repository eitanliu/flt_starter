import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class PreferredSizBuilder extends SingleChildStatelessWidget
    implements PreferredSizeWidget {
  final BuildContext context;
  final Size _preferredSize;
  final double? height;
  final PreferredSizeWidget? bottom;
  final TransitionBuilder? builder;

  PreferredSizBuilder({
    Key? key,
    required this.context,
    Size? preferredSize,
    this.height,
    this.bottom,
    Widget? child,
    this.builder,
  })  : _preferredSize = bottom == null
            ? preferredSize ?? getToolbarSize(context, height)
            : Size.fromHeight(
                (preferredSize ?? getToolbarSize(context, height)).height +
                    bottom.preferredSize.height,
              ),
        super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return builder?.call(context, child) ?? child ?? const SizedBox();
  }

  @override
  Size get preferredSize => _preferredSize;

  static double getToolbarHeight(BuildContext context) {
    return AppBarTheme.of(context).toolbarHeight ?? kToolbarHeight;
  }

  static Size getToolbarSize(BuildContext context, [double? height]) {
    return Size.fromHeight(height ?? getToolbarHeight(context));
  }
}
