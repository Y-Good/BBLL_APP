import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';

class DiscoverDetailController extends GetxController {
  FijkPlayer player = FijkPlayer();
  DiscoverShowConfig videoShowConfig = DiscoverShowConfig();
  String gg =
      'https://gd-sycdn.kuwo.cn/30b2f651e79c7cd625bdc992d0cb1319/620f48c2/resource/m1/97/9/2373198294.mp4';
  @override
  void onInit() {
    player.setDataSource(
        'https://gd-sycdn.kuwo.cn/30b2f651e79c7cd625bdc992d0cb1319/620f48c2/resource/m1/97/9/2373198294.mp4',
        showCover: true);
    super.onInit();
  }
}
