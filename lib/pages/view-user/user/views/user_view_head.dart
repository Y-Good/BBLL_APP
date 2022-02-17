import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_controller.dart';

class UserHeadItem {
  IconData icon;
  String? path;
  UserHeadItem({required this.icon, this.path});
}

class UserViewHead extends GetView<UserController> {
  const UserViewHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserHeadItem> userHeadList = [
      UserHeadItem(icon: IconFonts.iconBianji, path: Routes.USER_EDIT),
      UserHeadItem(icon: IconFonts.iconTongzhi, path: Routes.NOTICES),
      UserHeadItem(icon: IconFonts.iconWodeshoucang),
      UserHeadItem(icon: IconFonts.iconShezhi, path: Routes.SETTING),
    ];
    return Container(
      padding:
          EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
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
                child: SizedBox(
                  height: 82,
                  width: 82,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.USER_ZONE),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img2.baidu.com/it/u=3782522808,1589825680&fm=26&fmt=auto'),
                    ),
                  ),
                ),
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
                          userHeadList.length,
                          (index) => MIcon(
                                userHeadList[index].icon,
                                size: 26,
                                onTap: () => controller
                                    .onPages(userHeadList[index].path ?? ''),
                              )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}