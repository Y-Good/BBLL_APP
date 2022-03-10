import 'dart:io' show File;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/common/m_pick_sheet.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_edit_controller.dart';

class UserEditView extends GetView<UserEditController> {
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
              onTap: () => Get.bottomSheet(MPickSheet(
                onTap: (e) => controller.imagePick(e),
              )),
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      Obx(() => MAvatar(
                            CommonUtils.handleSrcUrl(
                              controller.user.value?.avatar ?? '',
                            ),
                            image: isNotNull(controller.imgPath.value)
                                ? FileImage(File(controller.imgPath.value))
                                : null,
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
  MFormItem({this.label, this.text});
}

class MForm {}
