import 'package:flt_starter/extension.dart';
import 'package:flt_starter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldBinding extends StatefulWidget {
  final String text;
  final TextRange composing;

  final ObservableValue<String?> valueListenable;

  final Widget Function(
    BuildContext context,
    String? value,
    TextFieldBindingState state,
  )? builder;

  const TextFieldBinding({
    Key? key,
    String? text,
    TextRange? composing,
    required this.valueListenable,
    this.builder,
  })  : text = text ?? "",
        composing = composing ?? TextRange.empty,
        super(key: key);

  @override
  State<TextFieldBinding> createState() => _TextFieldBindingState();
}

class _TextFieldBindingState extends State<TextFieldBinding>
    implements TextFieldBindingState {
  TextEditingController? _controller;

  @override
  TextEditingController get controller => _controller ??= _buildController();

  TextEditingController _buildController() {
    return TextEditingController.fromValue(
      TextEditingValue(
        // 设置内容
        text: widget.text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.text.length,
          ),
        ),
        composing: widget.composing,
      ),
    );
  }

  @override
  void onChanged(String text) {
    final notifier = widget.valueListenable.asSafeType<Observable<String?>>();
    notifier?.value = text;
  }

  @override
  Widget build(BuildContext context) {
    return widget.valueListenable.listen((value) {
      if (controller.text != value) {
        controller.text = value ?? '';
      }
      Widget child =
          widget.builder?.call(context, value, this) ?? const SizedBox();
      return child;
    });
  }
}

abstract class TextFieldBindingState {
  TextEditingController get controller;

  void onChanged(String text);
}
