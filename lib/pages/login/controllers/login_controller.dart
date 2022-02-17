import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/server/server.dart';
import 'package:mvideo/utils/common/common_utils.dart';

class LoginController extends GetxController {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  String? number;
  String? password;

  void submit() async {
    try {
      GetStorage st = GetStorage();
      var res = await Dio().post('${Server.host}/user/login',
          data: {'number': number, 'password': password});
      st.write('token', res.data['data']['token']);
      // print(SpUtil().getString('token'));
      Get.back(result: res.data['data']['token']);
    } on DioError catch (error) {
      // print(error.response?.data);
      CommonUtils.toast(error.response?.data['message']);
    }
  }

  @override
  void onClose() {
    numberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
