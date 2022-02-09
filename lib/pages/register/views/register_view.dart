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
      backgroundColor: Colors.white,
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
                      MInput(
                        direction: Axis.vertical,
                        label: '账号',
                        bgColor: MColors.backgroundColor,
                        // textEditingController: controller.numberController,
                        // onChange: (value) => controller.number = value,
                      ),
                      SizedBox(height: 16),
                      MInput(
                        direction: Axis.vertical,
                        label: '密码',
                        bgColor: MColors.backgroundColor,
                      ),
                      MInput(
                        direction: Axis.vertical,
                        label: '再次输入密码',
                        bgColor: MColors.backgroundColor,
                      ),
                      MInput(
                        direction: Axis.vertical,
                        label: '昵称',
                        bgColor: MColors.backgroundColor,
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
                // onTap: controller.submit,
              ))
        ],
      ),
    );
  }
}
