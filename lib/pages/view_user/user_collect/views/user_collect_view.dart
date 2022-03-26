import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/videos/video_width_card.dart';

import '../controllers/user_collect_controller.dart';

class UserCollectView extends GetView<UserCollectController> {
  @override
  Widget build(BuildContext context) {
    var items = controller.collectList;
    return Scaffold(
      appBar: MAppBar(title: '收藏'),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (_, index) {
            items[index].video?.time = items[index].time;
            return VideoWidthCard(
              item: controller.collectList[index].video,
              isFormatTime: true,
            );
          },
          itemCount: controller.collectList.length,
        ),
      ),
    );
  }
}
