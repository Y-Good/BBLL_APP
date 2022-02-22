import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/common/m_appbar.dart';
import 'package:mvideo/widgets/common/m_button.dart';
import 'package:mvideo/widgets/common/m_input.dart';
import 'package:mvideo/widgets/text/m_text.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,
      resizeToAvoidBottomInset: false,
      appBar: MAppBar(
        // hiddenLeading: controller.hiddenLeading,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: MText(
                '注册',
                size: 18,
                onTap: () => controller.onRegister(),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 32,
              child: MText(
                'Hi',
                size: 64,
              )),
          Positioned(
            top: 156,
            child: Container(
                width: 240,
                child: Column(
                  children: [
                    MInput(
                      direction: Axis.vertical,
                      label: '账号',
                      bgColor: MColors.background,
                      textEditingController: controller.numberController,
                      onChange: (value) => controller.number = value,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MInput(
                      direction: Axis.vertical,
                      label: '密码',
                      obscureText: true,
                      bgColor: MColors.background,
                      textEditingController: controller.passwordController,
                      onChange: (value) => controller.password = value,
                    )
                  ],
                )),
          ),
          Positioned(
              bottom: 50,
              child: MButton(
                width: 240,
                label: '登录',
                onTap: controller.submit,
              ))
        ],
      ),
    );
  }
}
