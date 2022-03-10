import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/common/m_swiper.dart';
import 'package:mvideo/widgets/public.dart';

class DefaultPage extends StatefulWidget {
  DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      onRefresh: () => controller.onInit(),
      header: ClassicalHeader(),
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Obx(
                    () => MSwiper(
                      // ignore: invalid_use_of_protected_member
                      bannerList: controller.bannerList.value,
                    ),
                  )),
              Obx(() => VideoGrid(
                    // ignore: invalid_use_of_protected_member
                    videoList: controller.videoList.value,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  )),
            ],
          )),
    );
  }
}
