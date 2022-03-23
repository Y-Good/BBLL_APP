import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/collect_request.dart';
import 'package:mvideo/config/http/request/comment_request.dart';
import 'package:mvideo/config/http/request/histroy_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

class VideoDetailController extends GetxController {
  final like = 33.obs;
  final isLike = false.obs;
  final isText = false.obs;
  final isFollow = false.obs;
  final isThumbUpVideo = false.obs;
  final isCollect = false.obs;
  final contentList = <Comment>[].obs;
  final secondCommentList = <Comment>[].obs;
  final userVideoList = <Video>[].obs;

  final contentController = TextEditingController();
  FijkPlayer player = FijkPlayer();
  FocusNode focus = FocusNode();
  Video? video;
  User? get user => UserUtils.getUser;
  bool get isUser => user?.id == video?.user?.id;
  String? content;

  @override
  void onInit() async {
    FijkVolume.setUIMode(2);
    video = Get.arguments['video'] ?? null;
    if (isNotNull(video?.url)) {
      player.setDataSource(CommonUtils.handleSrcUrl(video?.url ?? ''),
          autoPlay: true, showCover: true);
    }

    ///获取评论
    contentList.value = await CommentRequest.getAllComment(video?.id) ?? [];

    ///添加历史记录
    HistroyRequset.createHistroy(video?.id);

    ///是否点赞
    isThumbUpVideo.value = await VideoRequest.isThumbUp(video?.id) ?? false;

    ///是否关注
    isFollow.value = await CollectRequest.isFollow(video?.user?.id) ?? false;

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
    if (UserUtils.hasToken == false) return CommonUtils.toast('请先登录APP');
    CommonUtils.toast(isFollow.value ? '取消关注' : '关注成功');
    isFollow.value = !isFollow.value;
    CollectRequest.createColloect(followId: video?.user?.id);
  }

  void onThumbUpComment(int? commentId) async {
    bool res = await CommentRequest.thumbUp(commentId) ?? false;
    if (res) {
      isLike.value ? like.value-- : like.value++;
      isLike.value = !(isLike.value);
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

  void onCreateSecond() {}

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
    super.onClose();
  }
}
