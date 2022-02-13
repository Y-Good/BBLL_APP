import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    List<String> tabText = ['全部', '视频', '用户', '直播'];
    List<Widget> tabs = List.generate(
      tabText.length,
      (index) => Tab(
        text: tabText[index],
        height: 36,
      ),
    );
    return Scaffold(
        appBar: MAppBar(
          titleWidget: MSearch(autofocus: true),
          actionWidget: MText('搜索', size: 16),
        ),
        body: MTabPageView(
          tabs: tabs,
          padding: EdgeInsets.zero,
          children: [
            VideoList(),
            VideoList(),
            VideoList(),
            VideoList(),
          ],
        ));
  }
}
