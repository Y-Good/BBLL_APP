import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/common/m_button.dart';
import '../controllers/user_controller.dart';

class UserViewLogin extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      width: double.infinity,
      color: MColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: SizedBox(
              height: 82,
              width: 82,
              child: InkWell(
                onTap: () => Get.toNamed(Routes.USER_ZONE),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img2.baidu.com/it/u=3782522808,1589825680&fm=26&fmt=auto'),
                ),
              ),
            ),
          ),
          MButton(
            width: 128,
            label: '登录/注册',
            onTap: () => controller.onPages(Routes.LOGIN),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
