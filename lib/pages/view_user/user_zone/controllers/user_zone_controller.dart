import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/widgets/public.dart';

class UserZoneController extends GetxController {
  int initialIndex = Get.arguments ?? 1;
  final followList = <User>[].obs;

  List<Widget> tabs = [
    Tab(text: "关注", height: 36),
    Tab(text: '视频', height: 36),
    Tab(text: '评论', height: 36),
  ];
  final videoList = <Video>[].obs;

  @override
  void onInit() async {
    followList.value = await UserRequest.getFollowList() ?? [];
    super.onInit();
  }

  void cancelFollow(int? followId) async {
    var dialog = await Get.defaultDialog(
      title: '提示',
      middleText: '您确定取消关注吗？',
      cancel: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: MButton(
          width: 80,
          height: 36,
          label: '取消',
          onTap: () => Get.back(result: false),
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: MButton(
            width: 80,
            height: 36,
            label: '确认',
            onTap: () => Get.back(result: true)),
      ),
      radius: 10,
    );
    if (dialog == true) {
      var res = await UserRequest.updateFollow(followId);
      if (res == true) {
        followList.removeWhere((e) => e.id == followId);
      }
    }
  }
}
