import 'package:flutter/cupertino.dart';
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

class UserController extends GetxController {
  final isLogin = true.obs;
  GetStorage? st;
  List<MenuItem> get menuList => [
        MenuItem(
            icon: IconFonts.iconWodeguanzhu, title: '我的关注', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconLive, title: '我的视频', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconPinglun, title: '我的评论', onTap: onMyZone),
        MenuItem(icon: IconFonts.iconLishijilu, title: '浏览记录'),
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

  void onTest() async {
    Get.defaultDialog(
        title: '标题',
        middleText: st?.read('token') ?? '杀杀杀',
        textConfirm: '确认',
        onConfirm: () => Get.close(1));
  }

  void onMyZone(int index) {
    Get.toNamed(Routes.USER_ZONE, arguments: index);
  }
}
