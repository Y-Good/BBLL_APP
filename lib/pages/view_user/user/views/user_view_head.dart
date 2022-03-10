import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_controller.dart';

class UserViewHead extends GetView<UserController> {
  const UserViewHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => print("object")),
      child: Container(
        padding:
            EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        width: double.infinity,
        decoration: BoxDecoration(
            color: MColors.white,
            image: DecorationImage(
                image: NetworkImage(
                  "https://img1.baidu.com/it/u=2471177670,3575582393&fm=26&fmt=auto",
                ),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Obx(() => MAvatar(
                        CommonUtils.handleSrcUrl(
                            isNotNull(controller.updateAvatar.value)
                                ? controller.updateAvatar.value
                                : controller.user?.avatar ?? ''),
                        height: 82,
                        width: 82,
                        onTap: () => Get.toNamed(Routes.USER_ZONE),
                      )),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 48,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            controller.userHeadList.length,
                            (index) => MIcon(
                                  controller.userHeadList[index].icon,
                                  size: 26,
                                  onTap: () => controller.onPages(
                                      controller.userHeadList[index].path ??
                                          ''),
                                )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
