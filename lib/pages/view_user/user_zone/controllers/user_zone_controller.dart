import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/comment/comment_request.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/config/http/request/video/video_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';

class UserZoneController extends GetxController {
  int initialIndex = Get.arguments ?? 1;
  final followList = <User>[].obs;
  final commentList = <Comment>[].obs;
  final videotList = <Video>[].obs;

  User? get user => UserUtils.getUser();

  List<Widget> tabs = [
    Tab(text: "关注", height: 36),
    Tab(text: '视频', height: 36),
    Tab(text: '评论', height: 36),
  ];
  final videoList = <Video>[].obs;

  @override
  void onInit() async {
    followList.value = await UserRequest.getFollow() ?? [];
    commentList.value = await CommentRequest.getMyComment() ?? [];
    videoList.value = await VideoRequest.getMyVideo() ?? [];
    super.onInit();
  }

  void cancelFollow(int? followId) async {
    var dialog = await CommonUtils.dialog('您确定取消关注吗？');

    if (dialog == true) {
      var res = await UserRequest.updateFollow(followId);
      if (res == true) {
        followList.removeWhere((e) => e.id == followId);
      }
    }
  }

  ///删除评论
  void removeComment(int? commentId, int index) async {
    bool isConfirm = await CommonUtils.dialog('确认删除该条评论吗？') ?? false;
    if (isConfirm) {
      bool isRemove = await CommentRequest.removeComment(commentId);
      if (isRemove) commentList.removeAt(index);
      CommonUtils.toast(isRemove ? '删除成功' : '删除失败');
    }
  }
}
