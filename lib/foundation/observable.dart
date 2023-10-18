import 'package:mobx/mobx.dart';

export 'package:flutter_mobx/flutter_mobx.dart' hide version;
export 'package:mobx/mobx.dart'
// hide
//     version,
//     IntExtension,
//     BoolExtension,
//     ObservableBoolExtension,
//     DoubleExtension,
//     StringExtension,
//     Interceptor;
    show
        // export 'package:mobx/src/api/action.dart';
        runInAction,
        untracked,
        transaction,
        // export 'package:mobx/src/api/annotations.dart'
        action,
        computed,
        readonly,
        observable,
        StoreConfig,
        MakeObservable,
        alwaysNotify,
        observableAlwaysNotEqual,
        // export 'package:mobx/src/api/async.dart'
        ObservableFuture,
        FutureStatus,
        ObservableStream,
        StreamStatus,
        AsyncAction,
        // export 'package:mobx/src/api/context.dart';
        mainContext,
        createContext,
        // export 'package:mobx/src/api/extensions.dart';
        ReactiveReadPolicy,
        ReactiveWritePolicy,
        ReactiveConfig,
        ReactiveContext,
        // export 'package:mobx/src/api/observable_collections.dart'
        ObservableList,
        ListChange,
        ListChangeListener,
        ObservableMap,
        MapChange,
        MapChangeListener,
        ObservableSet,
        SetChange,
        SetChangeListener,
        // export 'package:mobx/src/api/reaction.dart';
        autorun,
        reaction,
        // export 'package:mobx/src/api/store.dart';
        Store,
        // export 'package:mobx/src/core.dart'
        // part 'core/action.dart';
        Action,
        ActionController,
        ActionRunInfo,
        // part 'core/atom.dart';
        Atom,
        // part 'core/computed.dart';
        Computed,
        // part 'core/derivation.dart';
        // part 'core/reaction.dart';
        Reaction,
        // part 'core/observable.dart';
        Observable,
        // part 'core/observable_value.dart';
        ObservableValue,
        // export 'package:mobx/src/core/atom_extensions.dart';
        AtomSpyReporter;

/// export 'package:mobx/src/core.dart'
/// part 'core/atom.dart';
typedef ObservableOperationType = OperationType;
typedef ObservableChangeNotification = ChangeNotification;
typedef ObservableWillChangeNotification = WillChangeNotification;
// part 'interceptable.dart';
typedef ObservableInterceptable = Interceptable;
// part 'listenable.dart';
typedef ObservableListenable = Listenable;
typedef ObservableListeners = Listeners;

void initMobxConfig({
  ReactiveWritePolicy? writePolicy = ReactiveWritePolicy.never,
}) {
  if (mainContext.config.writePolicy == writePolicy) return;
  mainContext.config = mainContext.config.clone(
    writePolicy: writePolicy,
  );
}
