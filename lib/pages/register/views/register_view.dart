import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(title: '注册'),
      backgroundColor: MColors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 56,
            child: Container(
                width: 240,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///懒得封装，能跑就行
                      MInput(
                        direction: Axis.vertical,
                        label: '账号',
                        maxInput: 16,
                        placeholder: '最长支持16个字符',
                        bgColor: MColors.background,
                        onChange: (value) => controller.number = value,
                      ),
                      SizedBox(height: 16),
                      MInput(
                        direction: Axis.vertical,
                        label: '密码',
                        bgColor: MColors.background,
                        obscureText: true,
                        onChange: (value) => controller.password = value,
                      ),
                      SizedBox(height: 16),
                      MInput(
                        direction: Axis.vertical,
                        label: '再次输入密码',
                        bgColor: MColors.background,
                        obscureText: true,
                        onChange: (value) => controller.validPassword = value,
                      ),
                      SizedBox(height: 16),
                      MInput(
                        direction: Axis.vertical,
                        label: '昵称',
                        bgColor: MColors.background,
                        onChange: (value) => controller.nickname = value,
                      )
                    ],
                  ),
                )),
          ),
          Positioned(
              bottom: 50,
              child: MButton(
                width: 240,
                label: '注册',
                onTap: controller.submit,
              ))
        ],
      ),
    );
  }
}
