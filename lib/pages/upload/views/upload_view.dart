import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/widgets/common/m_player.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> uploadList = [
      MCell(
        label: '标题',
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MInput(placeholder: '请输入标题'),
        ),
        trailing: SizedBox(width: 0),
      ),
      Container(
        padding: EdgeInsets.all(16),
        color: MColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [MText('封面'), SizedBox(height: 4), uplaodCover()],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        color: MColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [MText('内容'), SizedBox(height: 4), uplaodPlay()],
        ),
      ),
      MCell(label: '标签'),
      MCell(label: '#话题'),
    ];

    return Scaffold(
        appBar: uploadAppBar(),
        body: ListView.builder(
            itemCount: uploadList.length,
            itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(top: .5),
                  child: uploadList[index],
                )));
  }

  ///视频封面
  Widget uplaodCover() {
    return Obx(() => controller.videoPath.value.isNotEmpty
        ? MPlayer(
            player: controller.player,
            height: Get.size.width * 9 / 16,
            customSkin: Stack(
              children: [
                Positioned(
                    top: 8,
                    right: 8,
                    child: MIcon(
                      Icons.close,
                      color: MColors.white,
                      onTap: controller.delVideo,
                    )),
                Center(
                  child: MIcon(
                    IconFonts.iconBofangqiBofang,
                    color: MColors.white,
                    size: 48,
                    onTap: () => Get.bottomSheet(
                        Container(
                            height: Get.height,
                            width: Get.width,
                            child: MPlayer(
                              player: controller.playerView,
                              showConfig: controller.vSkinCfg,
                              curPlayUrl: controller.videoPath.value,
                            )),
                        isScrollControlled: true),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: MIcon(IconFonts.iconShangchuan,
                color: Colors.black54,
                size: 64,
                onTap: () => Get.bottomSheet(videoPickWidget())),
          ));
  }

  ///上传  视频的显示
  Widget uplaodPlay() {
    return Obx(() => controller.videoPath.value.isNotEmpty
        ? MPlayer(
            player: controller.player,
            height: Get.size.width * 9 / 16,
            customSkin: Stack(
              children: [
                Positioned(
                    top: 8,
                    right: 8,
                    child: MIcon(
                      Icons.close,
                      color: MColors.white,
                      onTap: controller.delVideo,
                    )),
                Center(
                  child: MIcon(
                    IconFonts.iconBofangqiBofang,
                    color: MColors.white,
                    size: 48,
                    onTap: () => Get.bottomSheet(
                        Container(
                            height: Get.height,
                            width: Get.width,
                            child: MPlayer(
                              player: controller.playerView,
                              showConfig: controller.vSkinCfg,
                              curPlayUrl: controller.videoPath.value,
                            )),
                        isScrollControlled: true),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: MIcon(IconFonts.iconShangchuan,
                color: Colors.black54,
                size: 104,
                onTap: () => Get.bottomSheet(videoPickWidget())),
          ));
  }

  ///弹出区域
  Widget videoPickWidget() {
    return Container(
      decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          2,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MIcon(
                controller.pickList[index].icon ?? Icons.add,
                size: 64,
                color: Colors.orangeAccent,
                onTap: () =>
                    controller.videoPick(controller.pickList[index].pickType),
              ),
              MText(controller.pickList[index].label ?? '')
            ],
          ),
        ),
      ),
    );
  }

  ///皮翻
  PreferredSizeWidget uploadAppBar() {
    return MAppBar(
      leading: MText('取消', size: 16, onTap: () => Get.back()),
      actionWidget: MText(
        '发布',
        size: 16,
        color: MColors.primiaryColor,
        onTap: () => controller.sumbit(),
      ),
    );
  }
}
