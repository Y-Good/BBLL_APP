import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/http.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class VideoDetailController extends GetxController {
  final like = 33.obs;
  final isLike = false.obs;
  final isText = false.obs;
  final isFollow = false.obs;
  final contents = [].obs;

  final contentController = TextEditingController();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = VideoShowConfig();
  FocusNode focus = FocusNode();
  String? content;
  String videoUrl =
      'http://192.168.0.174:3000/static/videos/2022-02-12/EZHZDr17RMRij-W0.mp4';
  @override
  void onInit() async {
    var res = await HttpUtil().get(
      '/api/comment',
    );
    FijkVolume.setUIMode(2);
    player.setDataSource(videoUrl, autoPlay: true);
    // await DefaultCacheManager().getSingleFile(videoUrl, key: 'test');

    contents.value = res['data'];
    contentController.addListener(() {
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
