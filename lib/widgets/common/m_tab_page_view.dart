import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';

class MTabPageView extends StatefulWidget {
  MTabPageView(
      {Key? key,
      required this.tabs,
      required this.children,
      this.isScrollable = false,
      this.elevation = 0.0,
      this.tabBackgroundColor,
      this.indicatorColor,
      this.labelColor,
      this.initialIndex,
      this.animateToPage = true,
      this.padding})
      : super(key: key);

  final List<Widget> tabs;

  final List<Widget> children;

  final double elevation;

  final Color? tabBackgroundColor;

  final bool isScrollable;

  final Color? labelColor;

  final Color? indicatorColor;

  final EdgeInsetsGeometry? padding;

  /// 初始页(初始页不能变更)
  final int? initialIndex;

  final bool animateToPage;

  @override
  MTabPageViewState createState() => MTabPageViewState();
}

class MTabPageViewState extends State<MTabPageView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  PageController? _pageController;
  bool _canDradding = true;
  int pageIndex = 0;

  bool get _onePage => widget.tabs.length == 1;

  void onJumpTo(int index) async {
    _canDradding = false;
    _tabController?.animateTo(index);
    await _pageController?.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    _canDradding = true;
  }

  void _onPageChanged(int index, {bool isPage = false}) async {
    pageIndex = index;
    if (!_canDradding) return;
    if (isPage) {
      _tabController?.animateTo(index);
    } else {
      _canDradding = false;
      if (widget.animateToPage) {
        await _pageController?.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _pageController?.jumpToPage(index);
      }
      _canDradding = true;
    }
  }

  /// 如果只有一个单界面，显示当前界面
  Widget _buildOnePage() {
    return widget.children.first;
  }

  /// 有多界面，显示PageView
  Widget _buildPages() {
    var color = Colors.black;
    if (_tabController == null ||
        widget.tabs.length != _tabController?.length) {
      _initial();
    }
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Material(
            color: widget.tabBackgroundColor ?? Theme.of(context).cardColor,
            elevation: widget.elevation,
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 40),
                child: TabBar(
                  padding: widget.padding ??
                      EdgeInsets.symmetric(horizontal: Get.size.width / 4),
                  labelStyle: TextStyle(fontSize: 16),
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 4,
                  isScrollable: widget.isScrollable,
                  controller: _tabController,
                  labelColor: widget.labelColor ?? color,
                  indicatorColor:
                      widget.indicatorColor ?? MColors.primiaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: widget.tabs,
                )),
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: PageView(
              controller: _pageController,
              dragStartBehavior: DragStartBehavior.start,
              children: List<Widget>.generate(
                widget.children.length,
                (index) => widget.children[index],
              ),
              onPageChanged: (index) => _onPageChanged(index, isPage: true),
            ),
          ),
        )
      ],
    );
  }

  void _initial() {
    if (!_onePage) {
      int currentIndex = _tabController?.index ?? 0;
      currentIndex = currentIndex >= widget.tabs.length ? 0 : currentIndex;
      _tabController?.dispose();
      _pageController?.dispose();
      //如果多个界面
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: currentIndex,
      );
      _pageController =
          PageController(initialPage: currentIndex, keepPage: false);
      _tabController?.addListener(() {
        if (_tabController?.indexIsChanging == true) {
          _onPageChanged(_tabController!.index);
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_tabController == null ||
        widget.tabs.length != _tabController?.length) {
      _initial();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null && !_onePage) {
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.initialIndex ?? 0,
      );
      _pageController = PageController(
        initialPage: widget.initialIndex ?? 0,
        keepPage: false,
      );
    }
    _initial();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _onePage ? _buildOnePage() : _buildPages();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }
}
