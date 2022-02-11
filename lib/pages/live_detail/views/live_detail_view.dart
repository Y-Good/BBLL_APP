import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/live_detail_controller.dart';

class LiveDetailView extends GetView<LiveDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            // physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FijkView(
                  height: Get.size.width * 9 / 16,
                  color: Colors.black,
                  fit: FijkFit.fill,
                  player: controller.player,
                  // cover: NetworkImage(
                  //     'https://img0.baidu.com/it/u=2811705907,124584203&fm=253&fmt=auto&app=138&f=PNG?w=600&h=307'),
                  panelBuilder: (
                    FijkPlayer player,
                    FijkData data,
                    BuildContext context,
                    Size viewSize,
                    Rect texturePos,
                  ) {
                    /// 使用自定义的布局
                    return CustomFijkPanel(
                      player: player,
                      playerTitle: '我是直播 ',
                      viewSize: viewSize,
                      texturePos: texturePos,
                      pageContent: context,
                      showConfig: controller.vSkinCfg,
                      curPlayUrl: controller.videoUrl,
                    );
                  },
                ),
                // expandedHeight: 230,
                collapsedHeight: Get.size.width * 9 / 16,
              ),
              SliverToBoxAdapter(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.white,
                    child: MIconText(icon: Icons.person, text: "100人")),
              ),
              SliverToBoxAdapter(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 35,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Container(
                      child: RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                            text: '基地u西安市啊：',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                              text: index % 3 == 0
                                  ? 'Get提供高级动态URL，就像在Web上一样。Web开发者可能已经在Flutter上想要这个功能了，Get也解决了这个问题。'
                                  : 'Get提供高Get也解决了这个问题。',
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                    ),
                  ),
                ),
              ),
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
                        padding:
                            const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                        child: MInput(
                          // textEditingController: controller.contentController,
                          bgColor: MColors.backgroundColor,
                          height: 32,
                          // onChange: (value) => controller.content = value,
                        ),
                      )),
                      MText(
                        '发布',
                        // color: controller.isText.value
                        //     ? MColors.primiaryColor
                        //     : Colors.grey,
                        // onTap: () => controller.submit(),
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
