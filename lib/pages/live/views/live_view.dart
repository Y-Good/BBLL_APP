import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/widgets/common/m_tab_page_view.dart';

import '../controllers/live_controller.dart';

class LiveView extends GetView<LiveController> {
  const LiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
        child: MTabPageView(
          initialIndex: 1,
          tabs: controller.tabs,
          children: controller.pageList,
        ),
      ),
    );
  }
}
