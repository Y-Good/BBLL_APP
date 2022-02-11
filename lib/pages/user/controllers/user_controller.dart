import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class MenuItem {
  IconData icon;
  String title;
  ValueChanged<int>? onTap;
  MenuItem({required this.icon, required this.title, this.onTap});
}

class UserController extends GetxController {
  final isLogin = true.obs;
  GetStorage? st;
  List<MenuItem> get menuList => [
        MenuItem(
            icon: IconFonts.iconWodeguanzhu, title: '我的关注', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconLive, title: '我的视频', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconPinglun, title: '我的评论', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconLishijilu, title: '浏览记录', onTap: onTest),
      ];
  @override
  void onInit() async {
    st = GetStorage();
    isLogin.value = isNull(st?.read('token'));
    super.onInit();
  }

  void onPages(String url) async {
    await Get.toNamed(url);
    isLogin.value = isNull(st?.read('token') ?? null);
  }

  void onTest(int index) async {
    CommonUtils.toast();
  }

  void onMyZone(int index) {
    Get.toNamed(Routes.USER_ZONE, arguments: index);
  }
}
