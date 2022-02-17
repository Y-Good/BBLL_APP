import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/common/m_button.dart';

class SettingItem {
  String? title;
  Function? onTap;
  Widget? trailing;
  SettingItem({this.title, this.onTap, this.trailing});
}

class SettingController extends GetxController {
  final isSwitch = false.obs;
  //列表
  List<List<SettingItem>> get items => [
        [SettingItem(title: '账号与安全', onTap: test)],
        [
          SettingItem(title: '测试1', onTap: test),
          SettingItem(title: '测试2', onTap: test),
          SettingItem(
              title: '测试3',
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
    print(isSwitch.value);
    super.onInit();
  }

  void test({e}) {
    print(e);
    print("色湖之");
  }

  void changeSwitch(e) {
    isSwitch.value = e;
  }

  void loginOut() async {
    GetStorage storage = GetStorage();

    var res = await Get.defaultDialog(
      title: '提示',
      middleText: '您确定退出此账号吗？',
      cancel: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: MButton(
          width: 80,
          height: 36,
          label: '取消',
          onTap: () => Get.back(result: false),
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: MButton(
            width: 80,
            height: 36,
            label: '确认',
            onTap: () => Get.back(result: true)),
      ),
      radius: 10,
    );

    if (Get.isDialogOpen == false && res == true) {
      storage.remove('token');
      Get.back();
    }
  }
}
