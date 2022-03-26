import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/user_request.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/utils.dart';

class LoginController extends GetxController {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  String? number;
  String? password;
  bool hiddenLeading = false;
  @override
  void onInit() {
    // hiddenLeading = Get.arguments['hiddenLeading'] ?? false;
    // print(Get.arguments['hiddenLeading']);
    super.onInit();
  }

  void onRegister() async {
    var res = await Get.toNamed(Routes.REGISTER);
    if (isNotNull(res)) {
      numberController.text = res;
      number = res;
    }
  }

  void submit() async {
    LoadingUtil.showLoading(msg: '正在登录');
    bool res = await UserRequest.userLogin(number, password);
    if (res == true) {
      UserRequest.getUserInfo();
      LoadingUtil.dismissLoading();
      Get.back();
    }
  }

  @override
  void onClose() {
    numberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
