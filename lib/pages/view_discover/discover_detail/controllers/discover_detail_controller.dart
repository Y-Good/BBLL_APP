import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiscoverDetailController extends GetxController {
  IO.Socket? socket;
  FijkPlayer player = FijkPlayer();
  DiscoverShowConfig discoverShowConfig = DiscoverShowConfig();
  User? user;
  String gg =
      'https://gd-sycdn.kuwo.cn/697efad4abe961b6cbbdb9ed0c8a0602/620f5859/resource/m3/35/83/2343069577.mp4';
  final msgList = <String>[].obs;
  final joinRoom = ''.obs;
  final people = 0.obs;
  @override
  void onInit() {
    socketInit();
    user = UserUtils.getUser;
    player.setDataSource(gg, showCover: true, autoPlay: true);

    ///房间消息
    socket?.on('room', (data) {
      msgList.add(data);
    });

    ///加入房间提示
    socket?.on('join', (data) {
      joinRoom.value = data;
      print(data);
    });

    ///在新人数
    socket?.on('people', (data) {
      people.value = data;
      print(data);
    });
    super.onInit();
  }

  @override
  void onClose() {
    player.dispose();
    socket?.dispose();
    super.onClose();
  }

  void onSumbit() {
    socket?.emit('msg', '哈哈哈哈');
  }

  void socketInit() {
    socket = IO.io(
        Server.socket,
        IO.OptionBuilder()
            .setTransports(['websocket']).setQuery({'uid': '333'}).build());
    socket?.connect();
    socket?.onConnect((res) {
      socket?.emit('joinRoom', '小蚂蚁');
      print('--------socket链接成功---------');
    });
  }
}
