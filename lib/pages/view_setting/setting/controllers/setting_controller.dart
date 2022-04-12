import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/pages/trend/controllers/trend_controller.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/setting_util.dart';

class SettingItem {
  String? title;
  Function? onTap;
  Widget? trailing;
  SettingItem({this.title, this.onTap, this.trailing});
}

class SettingController extends GetxController {
  final isSwitch = false.obs;
  final trendCtl = Get.find<TrendController>();
  //列表
  List<List<SettingItem>> get items => [
        [SettingItem(title: '更改密码', onTap: onAccount)],
        [
          SettingItem(title: '占位', onTap: test),
          SettingItem(title: '占位', onTap: test),
          SettingItem(
              title: '视频自动播放',
              onTap: test,
              trailing: Obx(
                () => FlutterSwitch(
                    width: 48,
                    padding: 2,
                    toggleSize: 20,
                    activeColor: MColors.primiaryColor,
                    value: isSwitch.value,
                    onToggle: (isSwitch) => changeSwitch(isSwitch)),
              ))
        ],
        [SettingItem(title: '检查更新', onTap: test)]
      ].obs;

  @override
  void onInit() {
    isSwitch.value = SettingUtil.getAutoPlay();
    super.onInit();
  }

  void test({e}) {
    print(e);
    print("色湖之");
  }

  void onAccount() {
    Get.toNamed(Routes.ACCOUNT);
  }

  void changeSwitch(e) {
    isSwitch.value = e;
    SettingUtil.autoPlay(e);
  }

  void loginOut() async {
    GetStorage storage = GetStorage();

    bool res = await CommonUtils.dialog('您确定退出此账号吗？') ?? false;

    if (Get.isDialogOpen == false && res == true) {
      storage.remove('token');
      storage.remove('user');
      trendCtl.onInit();
      Get.back();
    }
  }
}
