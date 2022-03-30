import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
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
          child: MInput(
            placeholder: '请输入标题',
            onChange: (e) => controller.title = e,
          ),
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
      MCell(
        label: '标签',
        title: Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: MLabel(
                    controller.checkTagName[index],
                    color: MColors.primiaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    radius: 20,
                    size: 12,
                  ),
                ),
                itemCount: controller.checkTagName.length,
              ),
            )),
        onTap: controller.pickTag,
      ),
      // MCell(label: '#话题'),
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
    return Obx(() => controller.coverPath.value.isNotEmpty
        ? Container(
            height: 150,
            child: Container(
                alignment: Alignment.centerLeft,
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Image.file(
                      File(controller.coverPath.value),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: MIcon(
                        Icons.close,
                        color: MColors.white,
                        onTap: controller.removeCover,
                      ),
                    ),
                  ],
                )),
          )
        : Center(
            child: MIcon(CupertinoIcons.photo,
                color: Colors.black54,
                size: 64,
                onTap: () => Get.bottomSheet(MPickSheet(
                      onTap: (e) => controller.coverPick(e),
                    ))),
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
                      onTap: controller.removeVideo,
                    )),
                Center(
                  child: MIcon(IconFonts.iconBofangqiBofang,
                      color: MColors.white, size: 48, onTap: () {
                    controller.playerView.setDataSource(
                        controller.videoPath.value,
                        autoPlay: true);
                    Get.bottomSheet(
                      Container(
                          height: Get.height,
                          width: Get.width,
                          child: MPlayer(
                            player: controller.playerView,
                            showConfig: controller.vSkinCfg,
                            curPlayUrl: controller.videoPath.value,
                          )),
                      isScrollControlled: true,
                    );
                  }),
                ),
              ],
            ),
          )
        : Center(
            child: MIcon(IconFonts.iconShangchuan,
                color: Colors.black54,
                size: 64,
                onTap: () => Get.bottomSheet(MPickSheet(
                      onTap: (e) => controller.videoPick(e),
                    ))),
          ));
  }

  ///皮翻
  PreferredSizeWidget uploadAppBar() {
    return MAppBar(
      leading: MText('取消', size: 16, onTap: () => Get.back()),
      actionWidget: MText(
        '发布',
        size: 16,
        color: MColors.primiaryColor,
        onTap: controller.onSumbit,
      ),
    );
  }
}
