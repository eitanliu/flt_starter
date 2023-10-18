import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class AutomaticKeepAliveWidget extends StatefulWidget
    with SingleChildStatefulWidgetMixin {
  final bool wantKeepAlive;
  final Widget? _child;
  final TransitionBuilder? builder;

  const AutomaticKeepAliveWidget({
    Key? key,
    this.wantKeepAlive = true,
    Widget? child,
    this.builder,
  })  : _child = child,
        super(key: key);

  @override
  State<AutomaticKeepAliveWidget> createState() =>
      _AutomaticKeepAliveWidgetState();

  @override
  Widget? get child => _child;
}

class _AutomaticKeepAliveWidgetState extends State<AutomaticKeepAliveWidget>
    with
        SingleChildStateMixin<AutomaticKeepAliveWidget>,
        AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    super.build(context);
    return widget.builder?.call(context, child) ?? child ?? const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildWithChild(context, widget.child);
  }
}
