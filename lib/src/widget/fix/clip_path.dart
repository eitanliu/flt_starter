import 'package:flutter/material.dart';

///
/// iOS Web 需要在使用 ClipPath 前调用
/// 可以是children开头占位或上层包含
///
class FixClipPath extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final TransitionBuilder? builder;

  const FixClipPath({
    Key? key,
    this.width,
    this.height,
    this.child,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: null,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.zero,
        ),
        child:
            builder?.call(context, child) ?? child ?? const SizedBox.shrink(),
      ),
    );
  }
}
