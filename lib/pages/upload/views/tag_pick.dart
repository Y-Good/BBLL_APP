import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/upload_controller.dart';

class TagPickWidget extends GetView<UploadController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MColors.white,
        height: Get.height / 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MIcon(
                      Icons.close,
                      size: 28,
                      onTap: () => Get.back(),
                    ),
                    MIcon(
                      Icons.check,
                      size: 28,
                      onTap: () {
                        controller.checkTagName.value = [];
                        controller.tags.value = controller.checkTagList;
                        controller.tagList.forEach((e) {
                          if (controller.checkTagList.contains(e.id)) {
                            controller.checkTagName.add(e.name!);
                          }
                        });
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Obx(() => Wrap(
                    children: List.generate(
                        controller.tagList.length,
                        (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 8,
                              ),
                              child: MLabel(
                                controller.tagList[index].name ?? '',
                                size: 16,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                onTap: () {
                                  if (controller.checkTagList.length >= 6 &&
                                      !controller.checkTagList.contains(
                                          controller.tagList[index].id!))
                                    return CommonUtils.toast('只能选择六个标签');
                                  controller.checkTagList.contains(
                                          controller.tagList[index].id!)
                                      ? controller.checkTagList
                                          .remove(controller.tagList[index].id!)
                                      : controller.checkTagList
                                          .add(controller.tagList[index].id!);
                                },
                                color: controller.checkTagList
                                        .contains(controller.tagList[index].id!)
                                    ? MColors.primiaryColor
                                    : MColors.grey9.withOpacity(0.5),
                              ),
                            )),
                  )),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: MButton(
                    width: 200,
                    label: '创建',
                    onTap: () async {
                      bool? isTrue = await CommonUtils.dialog('创建标签',
                          content: MInput(
                            bgColor: Colors.grey.withOpacity(0.2),
                            height: 48,
                            onChange: (val) => controller.tagName = val,
                          ));
                      if (isTrue == true) {
                        controller.createTag();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
