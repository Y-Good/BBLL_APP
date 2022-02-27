import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
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
            InkWell(
              onTap: () => print("object"),
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      MAvatar(
                        'https://img1.baidu.com/it/u=2929809463,2042799416&fm=253&fmt=auto&app=120&f=JPEG?w=690&h=690',
                        width: 80,
                        height: 80,
                      ),
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
                return newListCell(
                    controller.test[index].label ?? '',
                    controller.test[index].text ?? '',
                    controller.test[index].value);
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

  Widget newListCell<T>(String label, String text, dynamic value) {
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
          MText(
            label,
            size: 14,
          ),
          Container(
              width: 200,
              alignment: Alignment.center,
              child: MInput(
                placeholder: text,
                textAlign: TextAlign.right,
                onChange: (val) => controller.gg = val,
              ))
        ],
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
