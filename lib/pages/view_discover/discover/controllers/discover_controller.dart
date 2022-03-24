import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/models/common/room.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/public.dart';

class DiscoverController extends GetxController {
  final roomList = <Room>[].obs;

  void onGetRoom() async {
    EasyLoading.show(status: '正在查找', dismissOnTap: false);
    roomList.value = await CommonRequest.getOnline() ?? [];
    if (roomList.length == 0) {
      EasyLoading.dismiss();
      return CommonUtils.toast('目前没有房间');
    }
    EasyLoading.dismiss();

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        height: Get.height / 2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: MText('房间', size: 16),
          ),
          Obx(
            () => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) => MListTile(
                url: CommonUtils.handleSrcUrl(
                  roomList[index].video?.cover ?? '',
                ),
                title: roomList[index].video?.title,
                subtitle: '${roomList[index].user?.nickname}正在观看',
                onTap: () {
                  Get.toNamed(Routes.DISCOVER_DETAIL,
                      arguments: {'room': roomList[index]});
                },
              ),
              itemCount: roomList.length,
            ),
          ),
        ]),
      ),
    );
  }
}
