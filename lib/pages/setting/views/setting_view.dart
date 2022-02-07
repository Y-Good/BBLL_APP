import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/common/m_cell.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/text/m_text.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    List<List<SettingItem>> items = controller.items;
    return Scaffold(
      backgroundColor: MColors.backgroundColor,
      appBar: MAppBar(title: '设置'),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  List<Widget> child = [];
                  items[index].forEach((item) => {
                        child.add(MCell(
                          label: item.title,
                          trailing: item.trailing ?? null,
                          onTap: () => item.onTap!() ?? null,
                        ))
                      });
                  return Column(
                    children: child,
                  );
                },
                separatorBuilder: (_, index) => SizedBox(height: 8),
                itemCount: items.length),
          ),
          GestureDetector(
            onTap: () => controller.loginOut(),
            child: Container(
              height: 48,
              color: Colors.white,
              width: Get.size.width,
              alignment: Alignment.center,
              child: MText('退出登录'),
            ),
          )
        ],
      )),
    );
  }
}
