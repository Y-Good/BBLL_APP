import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/pages/video_detail/views/comment_cell.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';
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
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Stack(
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
                    showConfig: controller.videoShowConfig,
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
                      onTap: () =>
                          controller.isUser ? null : controller.onUserZone(),
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
                                (index) => MLabel(
                                      video?.tags?[index].name ?? '',
                                    )),
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
                SliverToBoxAdapter(child: commentArea()),
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
                            placeholder: isNotNull(controller.placeholder.value)
                                ? controller.placeholder.value
                                : null,
                            textEditingController: controller.contentController,
                            onSubmit: () => controller.isText.value
                                ? controller.onSubmit(context)
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
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
                            onTap: () {
                              if (UserUtils.hasToken == false)
                                return CommonUtils.toast('请先登录App');
                              controller.player.pause();
                              Get.toNamed(Routes.DISCOVER_DETAIL,
                                  arguments: {'video': controller.video});
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  ///评论区
  Widget commentArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
              () => MText('评论(${controller.commentList.length}条)', size: 16)),
        ),
        Obx(() => controller.commentList.length == 0
            ? MEmpty(text: '暂无评论')
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) =>
                    controller.commentList[index].level == 2
                        ? SizedBox()
                        : CommentCell(
                            item: controller.commentList[index], index: index),
                itemCount: controller.commentList.length,
              )),
        SizedBox(height: 88)
      ],
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
