import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadController());
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
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 16 / 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText('内容'),
              Center(
                child: MIcon(
                  Icons.cloud_upload,
                  color: Colors.black54,
                  size: 128,
                  onTap: controller.imagePick,
                ),
              )
            ],
          ),
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

  ///皮翻
  PreferredSizeWidget uploadAppBar() {
    return MAppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10),
        child: MText('取消', size: 18, onTap: () => Get.back()),
      ),
      actionWidget: MText(
        '发布',
        size: 18,
        color: MColors.primiaryColor,
        onTap: () => controller.sumbit(),
      ),
    );
  }
}
