import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/user/views/user_view_head.dart';
import 'package:mvideo/pages/user/views/user_view_login.dart';
import 'package:mvideo/widgets/common/m_cell.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    var items = controller.menuList;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => controller.isLogin.value ? UserViewLogin() : UserViewHead(),
        ),
        SizedBox(height: 16),
        Expanded(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return MCell(
                    icon: items[index].icon,
                    label: items[index].title,
                    onTap: items[index].onTap ?? null,
                  );
                },
                separatorBuilder: (_, index) => Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                itemCount: items.length),
          ),
        )
      ],
    ));
  }
}
