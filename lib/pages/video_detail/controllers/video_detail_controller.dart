import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/comment/comment_request.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

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

  @override
  void onInit() async {
    FijkVolume.setUIMode(2);
    video = Get.arguments['video'];
    if (isNotNull(video?.url)) {
      player.setDataSource(video!.url!, autoPlay: true, showCover: true);
    }
    user = UserUtils.getUser;

    ///获取评论
    contentList.value = await CommentRequest.getAllComment(video?.id) ?? [];

    ///关注
    followList = await UserRequest.getFollow();
    isFollow.value = followList?.contains(video?.user) ?? false;
    followList?.forEach((e) {
      if (e.id == video?.user?.id) isFollow.value = true;
    });

    contentController.addListener(() {
      isText.value = isNotNull(contentController.text);
    });
    super.onInit();
  }

  Future<void> onSubmit() async {
    bool isSubmit = await CommentRequest.createComment(video?.id, content);
    List<Comment> res = await CommentRequest.getAllComment(video?.id) ?? [];
    contentList.insert(0, res.last);
    CommonUtils.toast(isSubmit ? '评论成功' : '评论失败');
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
}
