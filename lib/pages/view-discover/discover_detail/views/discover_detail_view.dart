import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/common/m_player.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/discover_detail_controller.dart';

class DiscoverDetailView extends GetView<DiscoverDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.blackBackground,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MColors.blackBackground,
      ),
      body: Stack(
        children: [
          Column(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    MIcon(
                      IconFonts.iconFanhui,
                      color: MColors.blackTipColor,
                      onTap: () => Get.back(),
                    ),
                    Expanded(
                      child: MListTile(
                        url:
                            'https://img2.baidu.com/it/u=1052567076,3275246168&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
                        title: '我的快点咯撒是快点咯撒',
                        subtitle: '123关注',
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        titleColor: MColors.white,
                        subtitleColor: MColors.blackTipColor,
                        trailing: MButton(
                          label: '关注',
                          width: 64,
                          height: 32,
                          bgColor: MColors.primiaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                color: MColors.black,
                child: MPlayer(
                  width: Get.width,
                  height: Get.width * 9 / 16,
                  player: controller.player,
                  curPlayUrl: controller.gg,
                ),
              ),
              Container(
                height: 88,
                width: Get.width,
                color: MColors.white,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: MText(
                          "撒大苏打",
                          color: MColors.white,
                        ),
                      );
                    },
                    itemCount: 20,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                // height: 56,
                alignment: Alignment.center,
                width: Get.size.width,
                color: Color(0xFF252836),
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
                          bgColor: Colors.black,
                          height: 32,
                          inputColor: MColors.white,
                          placeholderColor: MColors.blackTipColor,
                          // onChange: (value) => controller.content = value,
                        ),
                      )),
                      MText(
                        '发布',
                        color: MColors.blackTipColor,
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
