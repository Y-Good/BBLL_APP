import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/view_user/user_zone/controllers/user_zone_controller.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class SearchUserPage extends StatelessWidget {
  final UserZoneController userZoneCtl = Get.put(UserZoneController());
  final List<User>? userList;
  SearchUserPage({Key? key, this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, index) => MListTile(
              url: CommonUtils.handleSrcUrl(userList?[index].avatar ?? ''),
              title: userList?[index].nickname ?? '-',
              backgroundColor: MColors.white,
              subtitle: isNotNull(userList?[index].signature)
                  ? (userList?[index].signature)
                  : '这个小可爱好懒',
              trailing: MButton(
                label: '已关注',
                width: 64,
                height: 32,
                bgColor: MColors.grey9.withOpacity(0.8),
                onTap: () => userZoneCtl.cancelFollow(userList?[index].id),
              ),
            ),
        itemCount: userList?.length);
  }
}
