import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/pages/home/views/default.dart';
import 'package:mvideo/pages/home/views/hot.dart';
import 'package:mvideo/pages/home/views/rank.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/common/m_badge.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabText = ['推荐', '热门', '排行', '电影'];
    List<Widget> tabs = List.generate(
      tabText.length,
      (index) => Tab(
        text: tabText[index],
        height: 36,
      ),
    );

    return Scaffold(
      appBar: MAppBar(
        hiddenLeading: true,
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: InkWell(
              onTap: () => Get.toNamed(Routes.SEARCH),
              child: MSearch(enabled: false)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: MBadge(
              hidden: false,
              dot: true,
              offset: Offset(-2, 8),
              child: MIcon(
                IconFonts.iconTongzhi,
                onTap: () => Get.toNamed(Routes.NOTICES),
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: MTabPageView(
          initialIndex: 0,
          padding: EdgeInsets.zero,
          tabs: tabs,
          children: [DefaultPage(), HotPage(), RankPage(), HotPage()]),
    );
  }
}
