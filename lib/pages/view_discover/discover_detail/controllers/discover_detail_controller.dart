import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/collect_request.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/common/message.dart';
import 'package:mvideo/models/common/room.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/video_detail/controllers/video_detail_controller.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiscoverDetailController extends GetxController {
  IO.Socket? socket;
  FijkPlayer player = FijkPlayer();
  FocusNode focusNode = FocusNode();
  DiscoverShowConfig discoverShowConfig = DiscoverShowConfig();
  BarrageWallController barrageWallController = BarrageWallController();
  TextEditingController textEditingController = TextEditingController();
  User? get user => UserUtils.getUser;
  Video? get video => Get.arguments['video'] ?? null;
  Room? get room => Get.arguments['room'] ?? null;
  int? get userId => video?.user?.id ?? room?.user?.id;
  bool get isUser => user?.id == userId;
  String? content;

  final VideoDetailController vdCtl = Get.put(VideoDetailController());
  final msgList = <Message>[].obs;
  final joinRoom = ''.obs;
  final people = 0.obs;
  final fans = '0'.obs;
  final isFollow = false.obs;
  final showTime = Random().nextInt(60000);
  @override
  Future<void> onInit() async {
    socketInit();
    var count = await CollectRequest.getCount(userId: userId);
    fans.value = count['fans'];

    ///是否关注
    isFollow.value = await CollectRequest.isFollow(userId) ?? false;
    player.reset();
    player.setDataSource(
      CommonUtils.handleSrcUrl(video?.url ?? room?.video?.url ?? ''),
      autoPlay: true,
    );

    ///房间消息
    socket?.on('room', (data) {
      Message msg = Message.fromJson(data);
      // if (msg.user?.id != user?.id) {
      msgList.add(msg);
      // }
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

  ///关注滴干活
  void onFollow() {
    if (UserUtils.hasToken == false) return CommonUtils.toast('请先登录APP');
    CommonUtils.toast(isFollow.value ? '取消关注' : '关注成功');
    isFollow.value = !isFollow.value;
    vdCtl.isFollow.value = isFollow.value;
    CollectRequest.createColloect(followId: video?.user?.id);
  }

  void onSumbit() {
    if (content == null) return CommonUtils.toast('请输入内容');
    socket?.emit('msg', content?.trim());
    FocusScope.of(Get.context!).requestFocus(focusNode);
    textEditingController.clear();
    content = null;
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

  @override
  void onClose() {
    player.dispose();
    socket?.dispose();
    textEditingController.dispose();
    barrageWallController.dispose();
    super.onClose();
  }
}
