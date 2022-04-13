import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/search/controllers/search_controller.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class SearchUserPage extends StatelessWidget {
  final SearchController searchCtl = Get.find<SearchController>();
  final List<User>? userList;
  SearchUserPage({Key? key, this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isNotNull(userList)
        ? ListView.builder(
            itemBuilder: (_, index) => MListTile(
                  onTap: () => Get.toNamed(
                    Routes.USER_ZONE,
                    arguments: {'user': userList?[index]},
                  ),
                  url: CommonUtils.handleSrcUrl(userList?[index].avatar ?? ''),
                  title: userList?[index].nickname ?? '-',
                  backgroundColor: MColors.white,
                  subtitle: isNotNull(userList?[index].signature)
                      ? (userList?[index].signature)
                      : '无无无',
                  trailing: MButton(
                    label: searchCtl.isFollow.value ? '已关注' : '关注',
                    width: 64,
                    height: 32,
                    bgColor: MColors.grey9.withOpacity(0.8),
                    onTap: () => searchCtl.cancelFollow(userList?[index].id),
                  ),
                ),
            itemCount: userList?.length)
        : MEmpty(
            text: '暂无搜索结果',
            type: Msvg.search,
          );
  }
}
