import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiscoverDetailController extends GetxController {
  IO.Socket? socket;
  FijkPlayer player = FijkPlayer();
  DiscoverShowConfig discoverShowConfig = DiscoverShowConfig();
  BarrageWallController barrageWallController = BarrageWallController();
  User? user;
  String gg =
      'https://gd-sycdn.kuwo.cn/697efad4abe961b6cbbdb9ed0c8a0602/620f5859/resource/m3/35/83/2343069577.mp4';
  final msgList = <String>[].obs;
  final joinRoom = ''.obs;
  final people = 0.obs;
  final showTime = Random().nextInt(60000);
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
      barrageWallController.send([
        Bullet(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: MIconText(
            icon: Icons.person,
            text: data,
            color: Colors.white,
          ),
        ))
      ]);
    });

    ///在新人数
    socket?.on('online', (data) {
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
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'userId': UserUtils.getUser?.id, 'videoId': '1'}).build());
    socket?.connect();
    socket?.onConnect((res) {
      print('--------socket链接成功---------');
    });
  }
}
