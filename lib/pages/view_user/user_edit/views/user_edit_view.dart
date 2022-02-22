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
            newListCell('昵称', "呜呜呜"),
            newListCell('签名', "呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜"),
            newListCell('性别', "男"),
            newListCell('生日', "呜呜呜"),
            newListCell('电话', "13333333333"),
          ],
        ),
      ),
    );
  }

  Widget newListCell(String label, String value) {
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
                placeholder: value,
                textAlign: TextAlign.right,
              ))
        ],
      ),
    );
  }
}
