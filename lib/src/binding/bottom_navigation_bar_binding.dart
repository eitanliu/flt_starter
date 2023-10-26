import 'package:flt_starter/extension.dart';
import 'package:flt_starter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarBinding extends StatelessWidget
    implements BottomNavigationBarBindingState {
  final ObservableValue<int> valueListenable;

  final Widget Function(
    BuildContext context,
    int currentIndex,
    BottomNavigationBarBindingState state,
  ) builder;

  const BottomNavigationBarBinding({
    Key? key,
    required this.valueListenable,
    required this.builder,
  }) : super(key: key);

  @override
  void onTap(int index) {
    final notifier = valueListenable.asSafeType<Observable<int>>();
    notifier?.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return valueListenable.listen((value) => builder(context, value, this));
  }
}

abstract class BottomNavigationBarBindingState {
  void onTap(int index);
}
