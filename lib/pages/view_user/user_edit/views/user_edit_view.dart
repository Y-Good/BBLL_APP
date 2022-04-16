import 'dart:io' show File;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_edit_controller.dart';
import 'dart:math' as math;

class UserEditView extends GetView<UserEditController> {
  ///直接手搓
  Widget mFormCell(String key, String label, String? value,
      {String? type = 'text'}) {
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
            flex: 2,
            child: MText(
              label,
              size: 14,
            ),
          ),
          type == MFormType.text
              ? Expanded(
                  flex: 8,
                  child: MInput(
                      placeholder: value ?? '无',
                      padding: EdgeInsets.zero,
                      textAlign: TextAlign.right,
                      onChange: (val) {
                        controller.params[key] = val;
                      }),
                )
              : SizedBox(),
          type == MFormType.gender
              ? Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      controller.params[key] =
                          await CommonUtils.mActionSheetValue(
                        {'男': 1, '女': 2},
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => MText(
                            CommonUtils.getGender(controller.params[key] ??
                                    int.parse(value ?? '0')) ??
                                '未知',
                            color: isNotNull(controller.params[key])
                                ? Colors.black
                                : CupertinoColors.placeholderText,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Transform.rotate(
                          angle: math.pi,
                          child: MIcon(
                            IconFonts.iconFanhui,
                            size: 16,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          type == MFormType.date
              ? Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      DatePicker.showDatePicker(
                        Get.context!,
                        showTitleActions: true,
                        onConfirm: (date) {
                          controller.params[key] = date.toString();
                        },
                        currentTime: DateTime.tryParse(
                                controller.params[key] ?? value) ??
                            DateTime.now(),
                        locale: LocaleType.zh,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => MText(
                              isNull(controller.params[key]) && isNull(value)
                                  ? '无'
                                  : CommonUtils.format(DateTime.tryParse(
                                          controller.params[key] ?? value)) ??
                                      '无',
                              color: isNotNull(controller.params[key])
                                  ? Colors.black
                                  : CupertinoColors.placeholderText,
                              textAlign: TextAlign.end,
                            )),
                        Transform.rotate(
                          angle: math.pi,
                          child: MIcon(
                            IconFonts.iconFanhui,
                            size: 16,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
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
                return Obx(() => mFormCell(
                      controller.uForm[index].key ?? '',
                      controller.uForm[index].label ?? '',
                      controller.uForm[index].value ?? '',
                      type: controller.uForm[index].type,
                    ));
              },
              itemCount: controller.uForm.length,
            )
          ],
        ),
      ),
    );
  }
}

class MFormItem {
  String? key;
  String? label;
  String? value;
  String? type;
  MFormItem({this.key, this.label, this.value, this.type = 'text'});
}

class MFormType {
  MFormType._();
  static String text = 'text';
  static String date = 'date';
  static String gender = 'gender';
}
