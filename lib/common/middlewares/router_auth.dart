import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';

class RouteAuthMiddleware extends GetMiddleware {
  // final int p;
  // RouteAuthMiddleware({ this.p=0});

  // @override
  // int? priority = p;

  @override
  RouteSettings? redirect(String? route) {
    GetStorage storage = GetStorage();
    if (storage.read('token') == null && Get.arguments == null) {
      CommonUtils.toast("请先登录APP");
      return RouteSettings(name: Routes.LOGIN);
    }
    return super.redirect(route);
  }
}
