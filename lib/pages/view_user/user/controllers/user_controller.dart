import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/utils.dart';

class MenuItem {
  IconData icon;
  String title;
  ValueChanged<int>? onTap;
  MenuItem({required this.icon, required this.title, this.onTap});
}

class UserHeadItem {
  IconData icon;
  String? path;
  UserHeadItem({required this.icon, this.path});
}

class UserController extends GetxController {
  final isLogin = true.obs;
  GetStorage? st = GetStorage();
  List<UserHeadItem> userHeadList = [
    UserHeadItem(icon: IconFonts.iconBianji, path: Routes.USER_EDIT),
    UserHeadItem(icon: IconFonts.iconTongzhi, path: Routes.NOTICES),
    UserHeadItem(icon: IconFonts.iconWodeshoucang),
    UserHeadItem(icon: IconFonts.iconShezhi, path: Routes.SETTING),
  ];
  List<MenuItem> get menuList => [
        MenuItem(
            icon: IconFonts.iconWodeguanzhu, title: '我的关注', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconLive, title: '我的视频', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconPinglun, title: '我的评论', onTap: onMyZone),
        MenuItem(
            icon: IconFonts.iconLishijilu, title: '历史记录', onTap: onHistory),
      ];
  @override
  void onInit() async {
    isLogin.value = isNull(st?.read('token'));
    super.onInit();
  }

  void onPages(String url) async {
    await Get.toNamed(url);
    isLogin.value = isNull(st?.read('token') ?? null);
  }

  Future<void> onHistory(int index) async {
    Get.toNamed(Routes.USER_HISTORY);
  }

  void onMyZone(int index) {
    Get.toNamed(Routes.USER_ZONE, arguments: index);
  }
}
