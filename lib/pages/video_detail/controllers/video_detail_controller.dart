import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/comment_request.dart';
import 'package:mvideo/config/http/request/histroy_request.dart';
import 'package:mvideo/config/http/request/user_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/utils/video_utils.dart';

class VideoDetailController extends GetxController {
  final like = 33.obs;
  final isLike = false.obs;
  final isText = false.obs;
  final isFollow = false.obs;
  final contentList = <Comment>[].obs;

  final contentController = TextEditingController();
  FijkPlayer player = FijkPlayer();
  FocusNode focus = FocusNode();
  Video? video;
  User? user;
  List<User>? followList;
  bool get isUser => user?.id == video?.user?.id;
  String? content;
  double? height;

  @override
  void onInit() async {
    FijkVolume.setUIMode(2);
    video = Get.arguments['video'];
    if (isNotNull(video?.url)) {
      player.setDataSource(CommonUtils.handleSrcUrl(video?.url ?? ''),
          autoPlay: true, showCover: true);
    }
    user = UserUtils.getUser;

    height = VideoUtils.getVideoHeight(video?.url ?? '');

    ///获取评论
    contentList.value = await CommentRequest.getAllComment(video?.id) ?? [];

    ///关注
    followList = await UserRequest.getFollow();
    isFollow.value = followList?.contains(video?.user) ?? false;
    followList?.forEach((e) {
      if (e.id == video?.user?.id) isFollow.value = true;
    });

    ///添加历史记录
    HistroyRequset.createHistroy(video?.id);

    contentController.addListener(() {
      isText.value = isNotNull(contentController.text);
    });
    super.onInit();
  }

  Future<void> onSubmit() async {
    Comment? res = await CommentRequest.createComment(video?.id, content);
    if (isNotNull(res)) {
      print(res?.time);
      contentList.insert(0, res!);
    }
    CommonUtils.toast(isNotNull(res) ? '评论成功' : '评论失败');
    // FocusScope.of(Get.context!).requestFocus(focus);
    focus.unfocus();
    contentController.clear();
  }

  ///删除评论
  void removeComment(int? commentId, int index) async {
    bool isConfirm = await CommonUtils.dialog('确认删除该条评论吗？') ?? false;
    if (isConfirm) {
      bool isRemove = await CommentRequest.removeComment(commentId);
      if (isRemove) contentList.removeAt(index);
      CommonUtils.toast(isRemove ? '删除成功' : '删除失败');
    }
  }

  ///关注滴干活
  void onFollow() {
    CommonUtils.toast(isFollow.value ? '取消关注' : '关注成功');
    isFollow.value = !isFollow.value;
    UserRequest.updateFollow(video?.user?.id);
  }

  void increment() {
    isLike.value ? like.value-- : like.value++;
    isLike.value = !(isLike.value);
  }

  @override
  void onClose() {
    player.dispose();
    contentController.dispose();
    super.onClose();
  }
}
