import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/common/m_search.dart';
import 'package:mvideo/widgets/common/m_swiper.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/videos/video_list.dart';
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
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
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
          bottom: TabBar(
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelColor: Colors.grey,
            indicatorColor: MColors.primiaryColor,
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs,
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: MSwiper(),
                ),
                Obx(() => VideoList(
                      // ignore: invalid_use_of_protected_member
                      videoList: controller.videoList.value,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )),
              ],
            )),
      ),
    );
  }
}
