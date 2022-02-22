import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/utils/common/common_utils.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String? number;
  String? password;
  String? validPassword;
  String? nickname;

  submit() async {
    if (password != validPassword) {
      return CommonUtils.toast("两次密码输入不一致");
    }

    bool? res = await UserRequest.userRegister(number, password, nickname);
    if (res == true) {
      CommonUtils.toast("注册成功");
      Get.back(result: number);
    }
  }
}
