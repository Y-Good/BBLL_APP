import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/live_view_all.dart';
import '../views/live_view_my.dart';

class LiveController extends GetxController {
  // TabController tabController = TabController(length: 2, vsync: this,initialIndex: 1);
  PageController pageController = PageController(initialPage: 1);
  List<Widget> pageList = [LiveViewMy(), LiveViewAll()];
  List<Widget> tabs = [
    Tab(text: "我的关注", height: 36),
    Tab(text: '全部直播', height: 36)
  ];
}
