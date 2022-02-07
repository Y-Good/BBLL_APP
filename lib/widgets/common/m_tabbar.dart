import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';

class MTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<Widget> tabs;
  final ValueChanged<int>? onTap;
  const MTabBar({Key? key, required this.tabs, this.tabController, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 16),
        unselectedLabelColor: Colors.grey,
        indicatorColor: MColors.primiaryColor,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabs,
        onTap: onTap,
      ),
    );
  }
}
