import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,
      appBar: MAppBar(
        title: '更改密码',
        actionWidget: MIcon(Icons.check, onTap: () => controller.onSubmit()),
      ),
      body: Container(
          width: 240,
          margin: EdgeInsets.only(top: 54),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MInput(
                  direction: Axis.vertical,
                  label: '旧密码',
                  bgColor: MColors.background,
                  obscureText: true,
                  onChange: (value) => controller.oldPwd = value,
                ),
                SizedBox(height: 16),
                MInput(
                  direction: Axis.vertical,
                  label: '新密码',
                  bgColor: MColors.background,
                  obscureText: true,
                  onChange: (value) => controller.newPwd = value,
                ),
                SizedBox(height: 16),
                MInput(
                  direction: Axis.vertical,
                  label: '再次输入新密码',
                  bgColor: MColors.background,
                  obscureText: true,
                  onChange: (value) => controller.validPwd = value,
                ),
              ],
            ),
          )),
    );
  }
}
