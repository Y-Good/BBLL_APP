import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/pages/home/views/default.dart';
import 'package:mvideo/pages/home/views/hot.dart';
import 'package:mvideo/pages/home/views/rank.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Tab(
        text: '推荐',
        height: 36,
      ),
      Tab(
        text: '热门',
        height: 36,
      ),
      Tab(
        text: '排行',
        height: 36,
      ),
      Tab(
        text: '电影',
        height: 36,
      )
    ];
    return Scaffold(
      appBar: MAppBar(
        isLeading: false,
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: InkWell(
              onTap: () => Get.toNamed(Routes.SEARCH),
              child: MSearch(enabled: false)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: MIcon(
              IconFonts.iconTongzhi,
              onTap: () => Get.toNamed(Routes.NOTICES),
              color: Colors.black,
            ),
          )
        ],
        // bottom: TabBar(
        //   labelColor: Colors.black,
        //   labelStyle: TextStyle(fontSize: 16),
        //   unselectedLabelColor: Colors.grey,
        //   indicatorColor: MColors.primiaryColor,
        //   indicatorWeight: 4,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   tabs: tabs,
        // ),
      ),
      body: MTabPageView(
          initialIndex: 0,
          padding: EdgeInsets.zero,
          tabs: tabs,
          children: [DefaultPage(), HotPage(), RankPage(), HotPage()]),
    );
  }
}
