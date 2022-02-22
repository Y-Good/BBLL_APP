import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class LiveDetailController extends GetxController {
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = LiveShowConfig();
  String videoUrl = "http://192.168.0.174:8000/live/test.flv";
  @override
  void onInit() {
    FijkVolume.setUIMode(2);
    player.setDataSource(videoUrl, autoPlay: true, showCover: true);
    super.onInit();
  }
}