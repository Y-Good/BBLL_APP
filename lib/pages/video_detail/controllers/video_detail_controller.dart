import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/utils/http.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/fijkplayer_skin/fijkplayer_skin.dart';

class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
}

class VideoDetailController extends GetxController {
  final like = 33.obs;
  final isLike = false.obs;
  final isText = false.obs;
  final contentController = TextEditingController();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = PlayerShowConfig();
  String? content;
  final contents = [].obs;
  @override
  void onInit() async {
    var res = await HttpUtil().get(
      '/api/comment',
    );
    FijkVolume.setUIMode(2);
    player.setDataSource(
        'http://192.168.0.189:3000/static/videos/2022-02-09/47-l5SOL3L2srbag.mp4',
        autoPlay: true);
    contents.value = res['data'];
    contentController.addListener(() {
      isText.value = isNotNull(contentController.text);
    });
    super.onInit();
  }

  void submit() {
    print(content);
  }

  void increment() {
    isLike.value ? like.value-- : like.value++;
    isLike.value = !(isLike.value);
  }
}
