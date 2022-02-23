import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/common/m_player.dart';
import 'package:mvideo/widgets/common/m_send_box.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/video_detail_controller.dart';

class VideoDetailView extends GetView<VideoDetailController> {
  @override
  Widget build(BuildContext context) {
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
                  fit: FijkFit.fill,
                  cover: '${Server.resources}${controller.video?.cover}',
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
                    url: '${Server.resources}${controller.video?.user?.avatar}',
                    title: controller.video?.user?.nickname,
                    subtitle: '3小时前',
                    trailing: Obx(() => MButton(
                          label: controller.isFollow.value ? '已关注' : '关注',
                          width: 64,
                          height: 32,
                          bgColor:
                              controller.isFollow.value ? MColors.grey9 : null,
                          onTap: controller.userFollow,
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
                        controller.video?.title ?? '',
                        size: 18,
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: List.generate(
                              controller.video?.tags?.length ?? 0,
                              (index) => MLabel(
                                  controller.video?.tags?[index].name ?? '')),
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
              child: Obx(
                (() => MSendBox(
                      changeColor: controller.isText.value,
                      onChange: (val) => controller.content = val,
                      textEditingController: controller.contentController,
                      onSubmit: () =>
                          controller.isText.value ? controller.submit() : null,
                    )),
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
          child: MText('评论', size: 16),
        ),
        Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) =>
                  commentWidget(controller.contents[index]['text']),
              itemCount: controller.contents.length,
            )),
        SizedBox(height: 48)
      ],
    );
  }

  ///评论组件
  Widget commentWidget(String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MAvatar(
            'https://img0.baidu.com/it/u=4183146585,2121935578&fm=26&fmt=auto',
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    '阿西吧',
                    size: 12,
                    color: Colors.grey,
                  ),
                  // MText('删除', size: 12, color: Colors.red),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MText(
                  content,
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
                  MText('3小时前', size: 12, color: Colors.grey),
                  Row(
                    children: [
                      Obx(() => MIconText(
                            iconSize: 17,
                            icon: controller.isLike.value
                                ? IconFonts.iconDianzan2
                                : IconFonts.iconDianzan1,
                            color: controller.isLike.value == true
                                ? MColors.primiaryColor
                                : null,
                            text: controller.like.value.toString(),
                            onTap: () => controller.increment(),
                          )),
                      SizedBox(width: 16),
                      MIconText(
                        icon: IconFonts.iconPinglun,
                        text: '99',
                        iconSize: 19,
                        onTap: () {
                          Get.bottomSheet(
                              Container(
                                  color: MColors.white,
                                  height: Get.height / 1.56,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        commentWidget(content),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return commentWidget('哈哈');
                                          },
                                          itemCount: 20,
                                        ),
                                      ],
                                    ),
                                  )),
                              barrierColor: Colors.transparent,
                              isScrollControlled: true);
                        },
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
