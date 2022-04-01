import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/collect_request.dart';
import 'package:mvideo/config/http/request/comment_request.dart';
import 'package:mvideo/config/http/request/histroy_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/setting_util.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

class VideoDetailController extends GetxController {
  final isText = false.obs;
  final isFollow = false.obs;
  final isThumbUpVideo = false.obs;
  final isCollect = false.obs;
  final placeholder = ''.obs;
  final commentList = <Comment>[].obs;
  final secondCommentList = <Comment>[].obs;
  final userVideoList = <Video>[].obs;

  final contentController = TextEditingController();
  FijkPlayer player = FijkPlayer();
  VideoShowConfig videoShowConfig = VideoShowConfig();
  FocusNode focus = FocusNode();
  Video? video;
  User? get user => UserUtils.getUser;
  bool get isUser => user?.id == video?.user?.id;
  String? content;

  ///二级评论
  ///评论父id
  int? parentId;
  int level = 1;

  @override
  void onInit() async {
    LoadingUtil.showLoading();
    FijkVolume.setUIMode(2);
    video = Get.arguments?['video'] ?? null;
    if (isNotNull(video?.url)) {
      player.setDataSource(CommonUtils.handleSrcUrl(video?.url ?? ''),
          autoPlay: SettingUtil.getAutoPlay(), showCover: true);
    }

    ///获取评论
    commentList.value =
        await CommentRequest.getAllComment(video?.id, user?.id ?? null) ?? [];

    ///添加历史记录
    HistroyRequset.createHistroy(video?.id);

    ///是否点赞
    isThumbUpVideo.value = await VideoRequest.isThumbUp(video?.id) ?? false;

    ///是否关注
    isFollow.value = await CollectRequest.isFollow(video?.user?.id) ?? false;

    contentController.addListener(() {
      isText.value = isNotNull(contentController.text);
    });
    LoadingUtil.dismissLoading();
    super.onInit();
  }

  Future<void> onSubmit() async {
    Comment? res;
    if (level == 2 && isNotNull(parentId)) {
      res = await CommentRequest.createSecond(video?.id, parentId, content);
    } else {
      res = await CommentRequest.createComment(video?.id, content);
    }
    if (isNotNull(res)) {
      res?.level == 1
          ? commentList.insert(0, res!)
          : secondCommentList.insert(0, res!);
    }
    CommonUtils.toast(isNotNull(res) ? '评论成功' : '评论失败');
    FocusScope.of(Get.context!).requestFocus(focus);
    contentController.clear();
  }

  ///删除评论
  void removeComment(int? commentId, int index) async {
    bool isConfirm = await CommonUtils.dialog('确认删除该条评论吗？') ?? false;
    if (isConfirm) {
      bool isRemove = await CommentRequest.removeComment(
        commentId,
        isNotNull(Get.isBottomSheetOpen) ? parentId : null,
      );
      if (isRemove) commentList.removeAt(index);
      if (Get.isBottomSheetOpen == true && isRemove) {
        secondCommentList.removeAt(index);
        commentList[index].replyCount = commentList[index].replyCount! - 1;
      }
      CommonUtils.toast(isRemove ? '删除成功' : '删除失败');
    }
  }

  ///关注滴干活
  void onFollow() {
    if (UserUtils.hasToken == false) return CommonUtils.toast('请先登录APP');
    CommonUtils.toast(isFollow.value ? '取消关注' : '关注成功');
    isFollow.value = !isFollow.value;
    CollectRequest.createColloect(followId: video?.user?.id);
  }

  void onThumbUpComment(int? commentId, index) async {
    bool res = await CommentRequest.thumbUp(commentId) ?? false;
    if (res) {
      commentList[index].isThumbUp = !commentList[index].isThumbUp!;
      commentList(commentList);
    }
  }

  void onThumbUpVideo() async {
    bool res = await VideoRequest.thumbUp(video?.id) ?? false;
    if (res == false) {
      CommonUtils.toast('点赞失败');
    } else {
      isThumbUpVideo.value = !isThumbUpVideo.value;
    }
  }

  void getSecondComment(int? parentId) async {
    secondCommentList.value =
        await CommentRequest.getSecondComment(parentId) ?? [];
  }

  ///收藏视频
  void onCollect() async {
    bool res = await CollectRequest.createColloect(videoId: video?.id) ?? false;
    if (res) isCollect.value = !isCollect.value;
  }

  ///获取用户视频
  Future<List<Video>> getUserVideos() async {
    return await VideoRequest.getMyVideo(video?.user?.id) ?? [];
  }

  @override
  void onClose() {
    player.dispose();
    contentController.dispose();
    LoadingUtil.dismissLoading();
    super.onClose();
  }
}
