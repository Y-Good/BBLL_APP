import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/common/m_swiper.dart';
import 'package:mvideo/widgets/public.dart';

class DefaultPage extends GetView<HomeController> {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
        ));
  }
}
