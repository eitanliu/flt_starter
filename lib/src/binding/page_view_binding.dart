import 'package:flt_starter/extension.dart';
import 'package:flt_starter/foundation.dart';
import 'package:flutter/material.dart';

class PageViewBinding extends StatefulWidget {
  final bool pageAutoJump;
  final bool pageAnimate;
  final Duration duration;
  final Curve curve;
  final TabController? tabController;

  final ObservableValue<int> valueListenable;

  final Widget Function(
    BuildContext context,
    int currentIndex,
    PageViewBindingState state,
  ) builder;

  const PageViewBinding({
    Key? key,
    this.pageAutoJump = true,
    this.pageAnimate = true,
    this.duration = kTabScrollDuration,
    this.curve = Curves.ease,
    this.tabController,
    required this.valueListenable,
    required this.builder,
  }) : super(key: key);

  @override
  State<PageViewBinding> createState() => _PageViewBindingState();
}

class _PageViewBindingState extends State<PageViewBinding>
    implements PageViewBindingState {
  bool onPageScrolling = false;
  TabController? _tabController;
  int? _currentIndex;

  // ignore: prefer_final_fields
  late PageController _pageController = PageController(
    initialPage: widget.valueListenable.value,
  );

  @override
  PageController get pageController => _pageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _currentIndex = _tabController?.index;
    // _pageController = PageController(initialPage: _currentIndex!);
  }

  @override
  void didUpdateWidget(PageViewBinding oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabController != oldWidget.tabController) {
      _updateTabController();
      _currentIndex = _tabController?.index;
      // jumpToPage(_currentIndex!);
    }
  }

  void _updateTabController() {
    final TabController newController =
        widget.tabController ?? DefaultTabController.of(context);

    if (newController == _tabController) return;

    _tabController?.removeListener(_handleTabControllerTick);
    _tabController = newController;
    if (_tabController != null) {
      _tabController!.addListener(_handleTabControllerTick);
      _currentIndex = _tabController!.index;
    }
  }

  void _handleTabControllerTick() {
    if (_tabController!.index != _currentIndex) {
      _currentIndex = _tabController!.index;
      onPageChanged(_currentIndex!);
      // final notifier = widget.valueListenable.asSafeType<ValueNotifier<int>>();
      // notifier?.value = _currentIndex!;
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.valueListenable.listen((value) {
      jumpToPage(value);
      return widget.builder(context, value, this);
    });
  }

  @override
  void onPageChanged(int index) {
    if (onPageScrolling) return;
    // final tabController = DefaultTabController.of(context);
    final notifier = widget.valueListenable.asSafeType<Observable<int>>();
    notifier?.value = index;
    _tabController?.let((value) {
      if (value.index != index) value.index = index;
    });
  }

  @override
  Future jumpToPage(int page) async {
    if (!(_pageController.hasClients && widget.pageAutoJump)) return;

    if (page == _pageController.page) return;

    if (widget.pageAnimate) {
      onPageScrolling = true;
      await _pageController.animateToPage(
        page,
        duration: widget.duration,
        curve: widget.curve,
      );
      onPageScrolling = false;
    } else {
      _pageController.jumpToPage(page);
    }
  }
}

abstract class PageViewBindingState {
  PageController get pageController;

  void onPageChanged(int index);

  Future jumpToPage(int page);
}
