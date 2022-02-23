import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/public.dart';

class UserZoneController extends GetxController {
  int initialIndex = Get.arguments ?? 1;
  final isFollow = true.obs;

  List<Widget> tabs = [
    Tab(text: "关注", height: 36),
    Tab(text: '视频', height: 36),
    Tab(text: '评论', height: 36),
  ];
  final videoList = <Video>[].obs;

  @override
  void onInit() async {
    var response = await HttpUtil().get(
      '/aip/video',
    );
    // videoList.value = Video.fromJson(response['data']);
    super.onInit();
  }

  void userFollow() {
    isFollow.value = !isFollow.value;
  }
}
