import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/routes/app_pages.dart';

class RouteAuthMiddleware extends GetMiddleware {
  // final int p;
  // RouteAuthMiddleware({ this.p=0});

  // @override
  // int? priority = p;

  @override
  RouteSettings? redirect(String? route) {
    GetStorage storage = GetStorage();
    if (storage.hasData('token')) {
      Get.snackbar("提示", "请先登录APP", duration: Duration(seconds: 2));
      return RouteSettings(name: Routes.LOGIN);
    }
    return super.redirect(route);
  }
}
