import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/common/comment.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/video_detail_controller.dart';

class VideoDetailView extends GetView<VideoDetailController> {
  @override
  Widget build(BuildContext context) {
    var video = controller.video;
    return Scaffold(
      backgroundColor: MColors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: MPlayer(
                  height: Get.size.width * 9 / 16,
                  fit: FijkFit.contain,
                  cover: video?.cover,
                  player: controller.player,
                  curPlayUrl: controller.video?.url,
                  title: controller.video?.title,
                ),
                collapsedHeight: Get.size.width * 9 / 16,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: MListTile(
                    backgroundColor: MColors.white,
                    url: CommonUtils.handleSrcUrl(video?.user?.avatar ?? ''),
                    title: video?.user?.nickname,
                    subtitle: CommonUtils.remindTime(video?.time),
                    onTap: () => controller.isUser
                        ? null
                        : Get.toNamed(Routes.USER_ZONE,
                            arguments: {'user': video?.user}),
                    trailing: controller.isUser
                        ? null
                        : Obx(() => MButton(
                              label: controller.isFollow.value ? '已关注' : '关注',
                              width: 64,
                              height: 32,
                              bgColor: controller.isFollow.value
                                  ? MColors.grey9.withOpacity(0.8)
                                  : null,
                              onTap: controller.onFollow,
                            )),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MText(
                        video?.title ?? '',
                        size: 18,
                      ),
                      SizedBox(height: video?.tags?.length == 0 ? 16 : 8),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: video?.tags?.length == 0 ? 0 : 8),
                        child: Row(
                          children: List.generate(
                              video?.tags?.length ?? 0,
                              (index) =>
                                  MLabel(video?.tags?[index].name ?? '')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 10,
                  width: Get.size.width,
                  color: MColors.background,
                ),
              ),
              SliverToBoxAdapter(child: comment()),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Obx(
                    (() => MSendBox(
                          changeColor: controller.isText.value,
                          onChange: (val) => controller.content = val,
                          textEditingController: controller.contentController,
                          onSubmit: () => controller.isText.value
                              ? controller.onSubmit()
                              : null,
                        )),
                  ),
                  Container(
                    color: MColors.white,
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 16, right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => MIcon(
                              controller.isThumbUpVideo.value
                                  ? IconFonts.iconDianzan2
                                  : IconFonts.iconDianzan1,
                              color: controller.isThumbUpVideo.value == true
                                  ? MColors.primiaryColor
                                  : null,
                              onTap: controller.onThumbUpVideo,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Obx(
                              () => MIcon(
                                IconFonts.iconWodeshoucang,
                                color: controller.isCollect.value
                                    ? MColors.primiaryColor
                                    : null,
                                size: 28,
                                onTap: controller.onCollect,
                              ),
                            )),
                        MIcon(
                          CupertinoIcons.share_up,
                          onTap: () => Get.toNamed(Routes.DISCOVER_DETAIL,
                              arguments: {'video': controller.video}),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  ///评论区
  Widget comment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
              () => MText('评论(${controller.contentList.length}条)', size: 16)),
        ),
        Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) =>
                  controller.contentList[index].level == 2
                      ? SizedBox()
                      : commentWidget(
                          item: controller.contentList[index], index: index),
              itemCount: controller.contentList.length,
            )),
        SizedBox(height: 88)
      ],
    );
  }

  ///评论组件
  Widget commentWidget({Comment? item, int? index}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MAvatar(
            CommonUtils.handleSrcUrl(
              item?.user?.avatar ?? '',
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText(
                item?.user?.nickname ?? '-',
                size: 13,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MText(
                  item?.content ?? '',
                  maxLines: 8,
                  onTap: () {
                    controller.contentController.text = '回复：啊西部';
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    CommonUtils.remindTime(item?.time) ?? '时间错误',
                    size: 12,
                    color: Colors.grey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => MIconText(
                            iconSize: 17,
                            icon: controller.isLike.value
                                ? IconFonts.iconDianzan2
                                : IconFonts.iconDianzan1,
                            color: controller.isLike.value == true
                                ? MColors.primiaryColor
                                : null,
                            text: item?.thumbUpCount.toString(),
                            onTap: () => controller.onThumbUpComment(item?.id),
                          )),
                      Offstage(
                        offstage: item?.level == 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: MIconText(
                            icon: IconFonts.iconPinglun,
                            text: item?.replyCount.toString(),
                            iconSize: 19,
                            onTap: () {
                              if (item?.replyCount == 0) return;
                              controller.getSecondComment(item?.id);
                              Get.bottomSheet(
                                  Container(
                                      height: Get.height / 1.56,
                                      padding: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        color: MColors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Obx(() => ListView.builder(
                                                padding:
                                                    EdgeInsets.only(top: 28),
                                                itemBuilder: (context, index) {
                                                  return commentWidget(
                                                      item: controller
                                                              .secondCommentList[
                                                          index]);
                                                },
                                                itemCount: controller
                                                    .secondCommentList.length,
                                              )),
                                          Positioned(
                                            left: 16,
                                            right: 16,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4),
                                              alignment: Alignment.center,
                                              color: Colors.white,
                                              child: MText(
                                                '评论回复',
                                                size: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  isScrollControlled: true);
                            },
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: controller.isUser
                            ? !controller.isUser
                            : !(item?.user?.id == controller.user?.id),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: MText(
                            '删除',
                            size: 12,
                            color: MColors.grey9,
                            onTap: () =>
                                controller.removeComment(item?.id, index ?? 0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
