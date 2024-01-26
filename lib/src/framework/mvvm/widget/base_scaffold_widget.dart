import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:view_model_provider/view_model_provider.dart';

import '../viewmodel/base_page_viewmodel.dart';
import 'base_appbar_widget.dart';
import 'base_status_widget.dart';
import 'base_viewmodel_widget.dart';

typedef BaseScaffoldWidgetBuilder<VM> = Widget? Function(
  BuildContext context,
  VM viewModel,
);

typedef BaseScaffoldAppBarBuilder<VM> = PreferredSizeWidget? Function(
  BuildContext context,
  VM viewModel,
);

typedef BaseScaffoldBodyBuilder<VM> = Widget? Function(
  BuildContext context,
  VM viewModel,
  Widget? child,
);

typedef BaseScaffoldStatusBuilder<VM> = Widget Function(
  BuildContext context,
  VM viewModel,
  Widget? child,
  BaseScaffoldBodyBuilder<VM> build,
);

typedef BaseScaffoldBuilder<VM> = Widget Function(
  BuildContext context,
  VM viewModel,
  Widget? child,
  BaseScaffoldBuilderFactory<VM> factory,
);

abstract class BaseScaffoldBuilderFactory<VM> {
  PreferredSizeWidget? buildAppBar(BuildContext context, VM viewModel);

  Widget? buildBottomNavigationBar(BuildContext context, VM viewModel);

  Widget? buildStatus(BuildContext context, VM viewModel, Widget? child);

  Widget? buildBody(BuildContext context, VM viewModel, Widget? child);
}

class BaseScaffoldWidget<VM extends BasePageViewModel>
    extends BaseViewModelWidget<VM> {
  final VM viewModel;

  final BaseScaffoldBuilder<VM>? builder;

  final BaseScaffoldAppBarBuilder<VM>? appBarBuilder;

  final BaseScaffoldStatusBuilder<VM>? statusBuilder;

  final BaseScaffoldBodyBuilder<VM>? bodyBuilder;

  final BaseScaffoldWidgetBuilder<VM>? bottomNavigationBarBuilder;

  final bool? extendStatus;

  /// If true, and [bottomNavigationBar] or [persistentFooterButtons]
  /// is specified, then the [body] extends to the bottom of the Scaffold,
  /// instead of only extending to the top of the [bottomNavigationBar]
  /// or the [persistentFooterButtons].
  ///
  /// If true, a [MediaQuery] widget whose bottom padding matches the height
  /// of the [bottomNavigationBar] will be added above the scaffold's [body].
  ///
  /// This property is often useful when the [bottomNavigationBar] has
  /// a non-rectangular shape, like [CircularNotchedRectangle], which
  /// adds a [FloatingActionButton] sized notch to the top edge of the bar.
  /// In this case specifying `extendBody: true` ensures that scaffold's
  /// body will be visible through the bottom navigation bar's notch.
  ///
  /// See also:
  ///
  ///  * [extendBodyBehindAppBar], which extends the height of the body
  ///    to the top of the scaffold.
  final bool extendBody;

  /// If true, and an [appBar] is specified, then the height of the [body] is
  /// extended to include the height of the app bar and the top of the body
  /// is aligned with the top of the app bar.
  ///
  /// This is useful if the app bar's [AppBar.backgroundColor] is not
  /// completely opaque.
  ///
  /// This property is false by default. It must not be null.
  ///
  /// See also:
  ///
  ///  * [extendBody], which extends the height of the body to the bottom
  ///    of the scaffold.
  final bool extendBodyBehindAppBar;

  /// A button displayed floating above [body], in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  final Widget? floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location, [FloatingActionButtonLocation.endFloat].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move the [floatingActionButton] to a new [floatingActionButtonLocation].
  ///
  /// If null, the [ScaffoldState] will use the default animator, [FloatingActionButtonAnimator.scaling].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A set of buttons that are displayed at the bottom of the scaffold.
  ///
  /// Typically this is a list of [TextButton] widgets. These buttons are
  /// persistently visible, even if the [body] of the scaffold scrolls.
  ///
  /// These widgets will be wrapped in an [OverflowBar].
  ///
  /// The [persistentFooterButtons] are rendered above the
  /// [bottomNavigationBar] but below the [body].
  final List<Widget>? persistentFooterButtons;

  /// A panel displayed to the side of the [body], often hidden on mobile
  /// devices. Swipes in from either left-to-right ([TextDirection.ltr]) or
  /// right-to-left ([TextDirection.rtl])
  ///
  /// Typically a [Drawer].
  ///
  /// To open the drawer, use the [ScaffoldState.openDrawer] function.
  ///
  /// To close the drawer, use [Navigator.pop].
  ///
  /// {@tool dartpad}
  /// To disable the drawer edge swipe, set the
  /// [Scaffold.drawerEnableOpenDragGesture] to false. Then, use
  /// [ScaffoldState.openDrawer] to open the drawer and [Navigator.pop] to close
  /// it.
  ///
  /// ** See code in examples/api/lib/material/scaffold/scaffold.drawer.0.dart **
  /// {@end-tool}
  final Widget? drawer;

  /// Optional callback that is called when the [Scaffold.drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed to the side of the [body], often hidden on mobile
  /// devices. Swipes in from right-to-left ([TextDirection.ltr]) or
  /// left-to-right ([TextDirection.rtl])
  ///
  /// Typically a [Drawer].
  ///
  /// To open the drawer, use the [ScaffoldState.openEndDrawer] function.
  ///
  /// To close the drawer, use [Navigator.pop].
  ///
  /// {@tool dartpad}
  /// To disable the drawer edge swipe, set the
  /// [Scaffold.endDrawerEnableOpenDragGesture] to false. Then, use
  /// [ScaffoldState.openEndDrawer] to open the drawer and [Navigator.pop] to
  /// close it.
  ///
  /// ** See code in examples/api/lib/material/scaffold/scaffold.end_drawer.0.dart **
  /// {@end-tool}
  final Widget? endDrawer;

  /// Optional callback that is called when the [Scaffold.endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  ///
  /// If this is null, then [DrawerThemeData.scrimColor] is used. If that
  /// is also null, then it defaults to [Colors.black54].
  final Color? drawerScrimColor;

  /// The color of the [Material] widget that underlies the entire Scaffold.
  ///
  /// The theme's [ThemeData.scaffoldBackgroundColor] by default.
  final Color? backgroundColor;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  ///
  /// Snack bars slide from underneath the bottom navigation bar while bottom
  /// sheets are stacked on top.
  ///
  /// The [bottomNavigationBar] is rendered below the [persistentFooterButtons]
  /// and the [body].
  final Widget? bottomNavigationBar;

  /// The persistent bottom sheet to display.
  ///
  /// A persistent bottom sheet shows information that supplements the primary
  /// content of the app. A persistent bottom sheet remains visible even when
  /// the user interacts with other parts of the app.
  ///
  /// A closely related widget is a modal bottom sheet, which is an alternative
  /// to a menu or a dialog and prevents the user from interacting with the rest
  /// of the app. Modal bottom sheets can be created and displayed with the
  /// [showModalBottomSheet] function.
  ///
  /// Unlike the persistent bottom sheet displayed by [showBottomSheet]
  /// this bottom sheet is not a [LocalHistoryEntry] and cannot be dismissed
  /// with the scaffold appbar's back button.
  ///
  /// If a persistent bottom sheet created with [showBottomSheet] is already
  /// visible, it must be closed before building the Scaffold with a new
  /// [bottomSheet].
  ///
  /// The value of [bottomSheet] can be any widget at all. It's unlikely to
  /// actually be a [BottomSheet], which is used by the implementations of
  /// [showBottomSheet] and [showModalBottomSheet]. Typically it's a widget
  /// that includes [Material].
  ///
  /// See also:
  ///
  ///  * [showBottomSheet], which displays a bottom sheet as a route that can
  ///    be dismissed with the scaffold's back button.
  ///  * [showModalBottomSheet], which displays a modal bottom sheet.
  final Widget? bottomSheet;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined by the
  /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true.
  final bool? resizeToAvoidBottomInset;

  /// Whether this scaffold is being displayed at the top of the screen.
  ///
  /// If true then the height of the [appBar] will be extended by the height
  /// of the screen's status bar, i.e. the top padding for [MediaQuery].
  ///
  /// The default value of this property, like the default value of
  /// [AppBar.primary], is true.
  final bool primary;

  /// {@macro flutter.material.DrawerController.dragStartBehavior}
  final DragStartBehavior drawerDragStartBehavior;

  /// The width of the area within which a horizontal swipe will open the
  /// drawer.
  ///
  /// By default, the value used is 20.0 added to the padding edge of
  /// `MediaQuery.of(context).padding` that corresponds to the surrounding
  /// [TextDirection]. This ensures that the drag area for notched devices is
  /// not obscured. For example, if `TextDirection.of(context)` is set to
  /// [TextDirection.ltr], 20.0 will be added to
  /// `MediaQuery.of(context).padding.left`.
  final double? drawerEdgeDragWidth;

  /// Determines if the [Scaffold.drawer] can be opened with a drag
  /// gesture.
  ///
  /// By default, the drag gesture is enabled.
  final bool drawerEnableOpenDragGesture;

  /// Determines if the [Scaffold.endDrawer] can be opened with a
  /// drag gesture.
  ///
  /// By default, the drag gesture is enabled.
  final bool endDrawerEnableOpenDragGesture;

  /// Restoration ID to save and restore the state of the [Scaffold].
  ///
  /// If it is non-null, the scaffold will persist and restore whether the
  /// [drawer] and [endDrawer] was open or closed.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  const BaseScaffoldWidget({
    Key? key,
    required this.viewModel,
    Widget? child,
    this.builder,
    this.appBarBuilder,
    this.statusBuilder,
    this.bodyBuilder,
    this.bottomNavigationBarBuilder,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendStatus,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key, child: child);

  @override
  SingleChildState<BaseScaffoldWidget<VM>> createState() =>
      _BaseScaffoldWidgetState<VM>();
}

class _BaseScaffoldWidgetState<VM extends BasePageViewModel>
    extends SingleChildState<BaseScaffoldWidget<VM>>
    implements BaseScaffoldBuilderFactory<VM> {
  VM get viewModel => widget.viewModel;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return widget.builder?.call(context, viewModel, child, this) ??
        buildScaffoldWidget(context, viewModel, child);
  }

  /// 根据 ViewModel 构建 [Scaffold]
  Widget buildScaffoldWidget(
    BuildContext context,
    VM viewModel,
    Widget? child,
  ) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: buildAppBar(context, viewModel),
          body: buildStatus(context, viewModel, child),
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
          persistentFooterButtons: widget.persistentFooterButtons,
          drawer: widget.drawer,
          onDrawerChanged: widget.onDrawerChanged,
          endDrawer: widget.endDrawer,
          onEndDrawerChanged: widget.onEndDrawerChanged,
          bottomNavigationBar: buildBottomNavigationBar(context, viewModel),
          bottomSheet: widget.bottomSheet,
          backgroundColor: widget.backgroundColor,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          primary: widget.primary,
          drawerDragStartBehavior: widget.drawerDragStartBehavior,
          extendBody: widget.extendBody,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          drawerScrimColor: widget.drawerScrimColor,
          drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
          restorationId: widget.restorationId,
        );
      },
    );
  }

  /// 构建 [Scaffold.appBar]
  @override
  PreferredSizeWidget? buildAppBar(
    BuildContext context,
    VM viewModel,
  ) {
    return widget.appBarBuilder != null
        ? widget.appBarBuilder?.call(context, viewModel)
        : viewModel.appBarVisible.value
            ? AppBarWidget(context, viewModel)
            : null;
  }

  /// 构建 [Scaffold.bottomNavigationBar]
  @override
  Widget? buildBottomNavigationBar(
    BuildContext context,
    VM viewModel,
  ) {
    return widget.bottomNavigationBarBuilder?.call(context, viewModel) ??
        widget.bottomNavigationBar;
  }

  /// 构建 [Scaffold.body]
  @override
  Widget? buildStatus(
    BuildContext context,
    VM viewModel,
    Widget? child,
  ) {
    return widget.statusBuilder != null
        ? widget.statusBuilder?.call(context, viewModel, child, buildBody)
        : buildStatusWidget(context, viewModel, child);
  }

  /// 构建 [Scaffold.body] 空状态展示内容
  Widget? buildStatusWidget(BuildContext context, VM viewModel, Widget? child) {
    return BaseStatusWidget(
      viewModel,
      expand: widget.extendStatus ?? widget.extendBody,
      builder: buildBody,
      child: child,
    );
  }

  /// 构建 [Scaffold.body] 展示内容
  @override
  Widget? buildBody(BuildContext context, VM viewModel, Widget? child) {
    return widget.bodyBuilder != null
        ? widget.bodyBuilder?.call(context, viewModel, child)
        : child ?? const SizedBox();
  }
}
