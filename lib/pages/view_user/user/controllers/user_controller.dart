import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/user_utils.dart';

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
  User? user;
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
    user = await UserRequest.getUserInfo();
    isLogin.value = !UserUtils.hasToken;
    super.onInit();
  }

  void onPages(String url) async {
    await Get.toNamed(url);
    isLogin.value = !UserUtils.hasToken;
  }

  Future<void> onHistory(int index) async {
    Get.toNamed(Routes.USER_HISTORY);
  }

  void onMyZone(int index) {
    Get.toNamed(Routes.USER_ZONE, arguments: index);
  }
}
