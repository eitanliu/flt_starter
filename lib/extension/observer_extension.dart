import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:nested/nested.dart';

//// 监听 Widget 扩展 ////

extension ObservableValueExtension<T> on ObservableValue<T> {
  Observer listen(
    Widget Function(T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(value),
    );
  }

  Observer build(
    Widget Function(BuildContext context, T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return Observer(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      builder: (BuildContext context) {
        return builder(context, value);
      },
    );
  }

  Observer buildChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(context, value, child),
    );
  }

  SingleChildWidget buildSingleChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    Key? sKey,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => build(
        key: key,
        name: name,
        warnWhenNoObservables: warnWhenNoObservables,
        (context, value) => builder(context, value, child),
      ),
    );
  }
}

extension ObservableListExtension<T extends ObservableList> on T {
  Observer listen(
    Widget Function(T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(value),
    );
  }

  Observer build(
    Widget Function(BuildContext context, T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return Observer(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      builder: (BuildContext context) {
        return builder(context, this);
      },
    );
  }

  Observer buildChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(context, value, child),
    );
  }

  SingleChildWidget buildSingleChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    Key? sKey,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => build(
        key: key,
        name: name,
        warnWhenNoObservables: warnWhenNoObservables,
        (context, value) => builder(context, value, child),
      ),
    );
  }
}

extension ObservableSetExtension<T extends ObservableSet> on T {
  Observer listen(
    Widget Function(T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(value),
    );
  }

  Observer build(
    Widget Function(BuildContext context, T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return Observer(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      builder: (BuildContext context) {
        return builder(context, this);
      },
    );
  }

  Observer buildChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(context, value, child),
    );
  }

  SingleChildWidget buildSingleChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    Key? sKey,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => build(
        key: key,
        name: name,
        warnWhenNoObservables: warnWhenNoObservables,
        (context, value) => builder(context, value, child),
      ),
    );
  }
}

extension ObservableMapExtension<T extends ObservableMap> on T {
  Observer listen(
    Widget Function(T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(value),
    );
  }

  Observer build(
    Widget Function(BuildContext context, T value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return Observer(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      builder: (BuildContext context) {
        return builder(context, this);
      },
    );
  }

  Observer buildChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(context, value, child),
    );
  }

  SingleChildWidget buildSingleChild(
    ValueWidgetBuilder<T> builder, {
    Key? key,
    Key? sKey,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => build(
        key: key,
        name: name,
        warnWhenNoObservables: warnWhenNoObservables,
        (context, value) => builder(context, value, child),
      ),
    );
  }
}

extension ListObservableValueExtension<T> on List<ObservableValue<T>> {
  Observer listen(
    Widget Function(List<T> value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return build(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      (context, value) => builder(value),
    );
  }

  Observer build(
    Widget Function(BuildContext context, List<T> value) builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
  }) {
    return Observer(
      key: key,
      name: name,
      warnWhenNoObservables: warnWhenNoObservables,
      builder: (BuildContext context) {
        final list = map((e) => e.value).toList();
        return builder(context, list);
      },
    );
  }

  Observer buildChild(
    ValueWidgetBuilder<List<T>> builder, {
    Key? key,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return build((context, value) => builder(context, value, child));
  }

  SingleChildWidget buildSingleChild(
    ValueWidgetBuilder<List<T>> builder, {
    Key? key,
    Key? sKey,
    String? name,
    bool? warnWhenNoObservables,
    Widget? child,
  }) {
    return SingleChildBuilder(
      key: sKey,
      child: child,
      builder: (context, child) => build(
        key: key,
        name: name,
        warnWhenNoObservables: warnWhenNoObservables,
        (context, value) => builder(context, value, child),
      ),
    );
  }
}
