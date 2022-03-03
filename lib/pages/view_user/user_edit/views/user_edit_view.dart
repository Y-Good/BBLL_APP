import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_edit_controller.dart';

class UserEditView extends GetView<UserEditController> {
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
                    controller.imagePick(controller.pickList[index].pickType),
              ),
              MText(controller.pickList[index].label ?? '')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        title: '编辑资料',
        actionWidget: MIcon(
          Icons.check,
          color: Colors.black,
          onTap: controller.onSubmit,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.bottomSheet(videoPickWidget()),
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      Obx(() => MAvatar(
                            controller.user.value?.avatar ?? '',
                            width: 80,
                            height: 80,
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                                height: 40,
                                color: Colors.black26,
                                // padding: EdgeInsets.all(8),
                                child: MIcon(
                                  IconFonts.iconBianji,
                                  color: MColors.white,
                                  size: 24,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  constraints: BoxConstraints(minHeight: 50),
                  color: MColors.white,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MText(
                          controller.test[index].label ?? '',
                          size: 14,
                        ),
                      ),
                      Expanded(
                        child: MInput(
                            placeholder: controller.test[index].text,
                            textAlign: TextAlign.right,
                            onChange: (val) {
                              controller.nickname = val;
                            }),
                      )
                    ],
                  ),
                );
              },
              itemCount: controller.test.length,
            )
            // newListCell('昵称', controller.user?.nickname ?? ''),
            // newListCell('签名', controller.user?.signature ?? ''),
            // newListCell(
            //     '性别', CommonUtils.getGender(controller.user?.gender) ?? '外星人'),
            // newListCell('生日', "呜呜呜"),
            // newListCell('电话', "13333333333"),
          ],
        ),
      ),
    );
  }
}

class MFormItem {
  String? label;
  String? text;
  dynamic value;
  MFormItem({this.label, this.value, this.text});
}

class MForm {}
