import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/video/video_request.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/utils.dart';

class VideoDetailController extends GetxController {
  final like = 33.obs;
  final isLike = false.obs;
  final isText = false.obs;
  final isFollow = false.obs;
  final contents = [].obs;

  final contentController = TextEditingController();
  FijkPlayer player = FijkPlayer();
  FocusNode focus = FocusNode();
  Video? video;
  String? content;
  @override
  void onInit() async {
    video = Get.arguments['video'];
    FijkVolume.setUIMode(2);
    if (isNotNull(video)) {
      player.setDataSource('${Server.resources}${video?.url}',
          autoPlay: true, showCover: true);
    }

    // contents.value = res['data'];
    contentController.addListener(() {
      print(contentController.text);
      isText.value = isNotNull(contentController.text);
    });
    super.onInit();
  }

  void submit() {
    contents.insert(0, {'text': content});
    focus.unfocus();
    // FocusScope.of(Get.context!).requestFocus(focus);
    contentController.clear();
  }

  void increment() {
    isLike.value ? like.value-- : like.value++;
    isLike.value = !(isLike.value);
  }

  void userFollow() {
    isFollow.value = !isFollow.value;
  }
}
