import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:mvideo/widgets/fijkplayer_skin/fijkplayer_skin.dart';

class LiveShowConfig implements ShowConfigAbs {
  @override
  bool speedBtn = false;
  @override
  bool topBar = true;
  @override
  bool lockBtn = false;
  @override
  bool bottomPro = false;
  @override
  bool stateAuto = true;
  @override
  bool liveMode = true;
}

class LiveDetailController extends GetxController {
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = LiveShowConfig();
  String videoUrl = "http://192.168.0.189:8000/live/test.flv";
  @override
  void onInit() {
    player.setDataSource(videoUrl, autoPlay: true, showCover: true);
    super.onInit();
  }
}
