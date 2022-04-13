import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/common/controllers/refresh_controller.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/common/trend.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/common/m_refresh.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/trend_controller.dart';

class TrendView extends GetView<TrendController> {
  final refreshCtl = Get.find<RefreshController>(tag: 'trend');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MAppBar(
          hiddenLeading: true,
          title: '动态',
          actionWidget: MIcon(
            Icons.more_vert,
            size: 24,
            onTap: controller.onMenu,
          ),
          bgcolor: MColors.white,
        ),
        body: Obx(
          () => controller.isUser.value == true
              ? MRefresh(
                  controller: refreshCtl.easyRefreshController,
                  onRefresh: controller.onInit,
                  isEmpty: controller.trendList.length == 0,
                  child: ListView.builder(
                    itemBuilder: (_, index) =>
                        trendCard(controller.trendList[index]),
                    itemCount: controller.trendList.length,
                  ),
                )
              : MEmpty(
                  type: Msvg.empty,
                  text: '登录App才能使用',
                ),
        ));
  }

  Widget trendCard(Trend item) {
    User user = User();
    user.avatar = item.avatar;
    user.nickname = item.nickname;
    user.id = item.id;
    item.video?.user = user;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: MColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MListTile(
              padding: EdgeInsets.symmetric(vertical: 6),
              url: CommonUtils.handleSrcUrl(item.avatar ?? ''),
              title: item.nickname,
              titleSize: 16,
              subtitle: CommonUtils.remindTime(item.video?.time),
            ),
            MText(item.video?.title ?? '-'),
            InkWell(
              onTap: () => Get.toNamed(
                Routes.VIDEO_DETAIL,
                arguments: {'video': item.video},
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: MAvatar(
                        CommonUtils.handleSrcUrl(item.video?.cover ?? ''),
                        height: (Get.size.width - 20) * 9 / 16,
                        width: double.infinity,
                        radius: 4,
                      ),
                    ),
                  ),
                  Positioned(
                      child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.black45,
                    ),
                    child: MIcon(
                      Icons.play_arrow,
                      color: MColors.white,
                      size: 36,
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
