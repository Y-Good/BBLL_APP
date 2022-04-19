import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/collect_request.dart';
import 'package:mvideo/config/http/request/comment_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/common/collect.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/models/type/collect_type.dart';
import 'package:mvideo/pages/video_detail/controllers/video_detail_controller.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

class UserZoneController extends GetxController {
  final followList = <Collect>[].obs;
  final commentList = <Comment>[].obs;
  final videotList = <Video>[].obs;
  final isFollow = false.obs;
  final followCount = '0'.obs;
  final fansCount = '0'.obs;
  int initialIndex = Get.arguments?['index'] ?? 1;
  User? argUser = Get.arguments?['user'];
  User? get user => argUser ?? UserUtils.getUser;

  List<Widget> tabs = [
    Tab(text: "关注", height: 36),
    Tab(text: '视频', height: 36),
    Tab(text: '评论', height: 36),
  ];

  final videoList = <Video>[].obs;

  @override
  void onInit() async {
    LoadingUtil.showLoading();
    if (isNotNull(argUser)) {
      isFollow.value = await CollectRequest.isFollow(user?.id) ?? false;
    }
    followList.value = await CollectRequest.getCollect(
          CollectType.user,
          userId: argUser?.id,
        ) ??
        [];
    commentList.value = await CommentRequest.getMyComment(user?.id) ?? [];
    videoList.value = await VideoRequest.getMyVideo(user?.id) ?? [];
    var count = await CollectRequest.getCount(userId: user?.id);
    followCount.value = count['follow'];
    fansCount.value = count['fans'];
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
    // if (Get.isBottomSheetOpen == true) Get.close(0);
    bool? res = await CommonUtils.dialog('确认删除？');
    if (res == true) {
      bool isRemove = await VideoRequest.removeVideo(videoId) ?? false;
      if (isRemove) {
        videotList.removeWhere((e) => e.id == videoId);
        videoList.refresh();
        CommonUtils.toast('删除成功');
        Get.close(0);
      }
    } else {
      Get.close(0);
    }
  }

  void onMenu(int? videoId) {
    Map<String, VoidCallback> sheet = {'删除': () => removeVideo(videoId)};
    CommonUtils.mActionSheet(sheet, isBack: false);
  }

  ///关注滴干活
  void onFollow() {
    final VideoDetailController vdCtl = Get.put(VideoDetailController());
    if (UserUtils.hasToken == false) return CommonUtils.toast('请先登录APP');
    CommonUtils.toast(isFollow.value ? '取消关注' : '关注成功');
    isFollow.value = !isFollow.value;
    vdCtl.isFollow.value = isFollow.value;
    CollectRequest.createColloect(followId: argUser?.id);
  }

  @override
  void onClose() {
    LoadingUtil.dismissLoading();
    super.onClose();
  }
}
