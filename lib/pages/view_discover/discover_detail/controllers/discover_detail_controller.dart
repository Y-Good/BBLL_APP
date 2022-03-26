import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/common/message.dart';
import 'package:mvideo/models/common/room.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiscoverDetailController extends GetxController {
  IO.Socket? socket;
  FijkPlayer player = FijkPlayer();
  DiscoverShowConfig discoverShowConfig = DiscoverShowConfig();
  BarrageWallController barrageWallController = BarrageWallController();
  User? get user => UserUtils.getUser;
  Video? get video => Get.arguments['video'] ?? null;
  Room? get room => Get.arguments['room'] ?? null;
  String? content;

  final msgList = <Message>[].obs;
  final joinRoom = ''.obs;
  final people = 0.obs;
  final showTime = Random().nextInt(60000);
  @override
  void onInit() {
    socketInit();
    player.setDataSource(
      CommonUtils.handleSrcUrl(video?.url ?? room?.video?.url ?? ''),
      autoPlay: true,
    );

    ///房间消息
    socket?.on('room', (data) {
      Message msg = Message.fromJson(data);
      if (msg.user?.id != user?.id) {
        msgList.add(Message.fromJson(data));
      }
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
    });
    super.onInit();
  }

  @override
  void onClose() {
    player.dispose();
    socket?.dispose();
    barrageWallController.dispose();
    super.onClose();
  }

  void onSumbit() {
    socket?.emit('msg', content);
  }

  void socketInit() {
    var params = {
      'userId': UserUtils.getUser?.id,
      'videoId': video?.id,
      'room': room?.room
    };
    params.removeWhere((key, value) => value == null);
    socket = IO.io(
        Server.socket,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery(params)
            .build());
    socket?.connect();
    socket?.onConnect((res) {
      print('--------socket链接成功---------');
    });
  }
}
