import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';

class DiscoverDetailController extends GetxController {
  FijkPlayer player = FijkPlayer();
  DiscoverShowConfig discoverShowConfig = DiscoverShowConfig();
  String gg =
      'https://gd-sycdn.kuwo.cn/697efad4abe961b6cbbdb9ed0c8a0602/620f5859/resource/m3/35/83/2343069577.mp4';
  @override
  void onInit() {
    player.setDataSource(gg, showCover: true, autoPlay: true);
    super.onInit();
  }
}
