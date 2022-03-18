import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/colloect_request.dart';
import 'package:mvideo/config/http/request/comment_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/common/collect.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/models/type/collect_type.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/user_utils.dart';

class UserZoneController extends GetxController {
  int initialIndex = Get.arguments ?? 1;
  final followList = <Collect>[].obs;
  final commentList = <Comment>[].obs;
  final videotList = <Video>[].obs;

  User? get user => UserUtils.getUser;

  List<Widget> tabs = [
    Tab(text: "关注", height: 36),
    Tab(text: '视频', height: 36),
    Tab(text: '评论', height: 36),
  ];

  final videoList = <Video>[].obs;

  @override
  void onInit() async {
    LoadingUtil.showLoading();
    followList.value = await CollectRequest.getCollect(CollectType.user) ?? [];
    commentList.value = await CommentRequest.getMyComment() ?? [];
    videoList.value = await VideoRequest.getMyVideo() ?? [];
    LoadingUtil.dismissLoading();
    super.onInit();
  }

  void cancelFollow(int? followId) async {
    var dialog = await CommonUtils.dialog('您确定取消关注吗？');

    if (dialog == true) {
      var res = await CollectRequest.createColloect(followId: followId);
      if (res == true) {
        followList.removeWhere((e) => e.follow?.id == followId);
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

  ///删除视频
  void removeVideo(int? videoId) async {
    bool? res = await CommonUtils.dialog('确认删除？');
    if (res == true) {
      bool isRemove = await VideoRequest.removeVideo(videoId) ?? false;
      if (isRemove) {
        videotList.removeWhere((e) => e.id == videoId);
        CommonUtils.toast('删除成功');
        Get.close(0);
      }
    } else {
      Get.close(0);
    }
  }

  void onMenu(int? videoId) {
    Map<String, VoidCallback> sheet = {'删除': () => removeVideo(videoId)};
    CommonUtils.mActionSheeet(sheet);
  }
}
