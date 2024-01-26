import '../widget/builder_widget.dart';

// typedef TransitionBuilderList = List<TransitionBuilder>;

extension WidgetBuilderOnListExtension on List {
  List transitionBuilder(TransitionBuilder builder) {
    add(builder);
    return this;
  }

  List widgetMapBuilder(WidgetConvertBuilder builder) {
    add(builder);
    return this;
  }
}

extension TransitionBuilderListExtension on List<TransitionBuilder> {
  List<TransitionBuilder> transitionBuilder(TransitionBuilder builder) {
    add(builder);
    return this;
  }
}
