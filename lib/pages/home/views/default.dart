import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/common/m_refresh.dart';
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
    return Obx(() => MRefresh(
          controller: controller.easyRefreshController,
          onRefresh: () => controller.onInit(),
          isEmpty: controller.videoList.length == 0,
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MSwiper(
                      // ignore: invalid_use_of_protected_member
                      bannerList: controller.bannerList.value,
                    ),
                  ),
                  VideoGrid(
                    videoList: controller.videoList,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ],
              )),
        ));
  }
}
