import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/video_detail_controller.dart';

class VideoDetailView extends GetView<VideoDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                elevation: 0,
                pinned: true,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                      splashColor: Colors.transparent)
                ],
                backgroundColor: Colors.black,
                flexibleSpace: Image.network(
                    "https://img0.baidu.com/it/u=4183146585,2121935578&fm=26&fmt=auto"),
                // expandedHeight: 230,
                collapsedHeight: Get.size.width * 9 / 16,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: MListTile(
                    backgroundColor: Colors.white,
                    url:
                        'https://img0.baidu.com/it/u=4183146585,2121935578&fm=26&fmt=auto',
                    title: '阿西吧',
                    subtitle: '3小时前',
                    trailing: MButton(
                      label: '关注',
                      width: 64,
                      height: 32,
                    ),
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
                        '变形价格',
                        size: 18,
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            MLabel('精彩'),
                            MLabel('搞笑'),
                            MLabel('哈哈'),
                          ],
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
                  color: MColors.backgroundColor,
                ),
              ),
              SliverToBoxAdapter(child: comment()),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 48,
                width: Get.size.width,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: MInput(
                          textEditingController: controller.contentController,
                          bgColor: MColors.backgroundColor,
                          height: 32,
                          onChange: (value) => controller.content = value,
                        ),
                      )),
                      Obx(() => MText(
                            '发布',
                            color: controller.isText.value
                                ? MColors.primiaryColor
                                : Colors.grey,
                            onTap: () => controller.submit(),
                          ))
                    ]),
              ))
        ],
      ),
    );
  }

  Widget comment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MText(
            '评论',
            size: 16,
          ),
          Obx(() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
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
                              MText('3小时前', size: 12, color: Colors.grey),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: MText(
                              controller.contents[index]['text'],
                              maxLines: 8,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(() => MIconText(
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
                              MIconText(icon: IconFonts.iconPinglun, text: '99')
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                itemCount: controller.contents.length,
              )),
          SizedBox(height: 48)
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
