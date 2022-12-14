import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/pages/search/views/search_synthesis.dart';
import 'package:mvideo/pages/search/views/search_user.dart';
import 'package:mvideo/pages/search/views/search_video.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MAppBar(
          titleWidget: MSearch(
            onChanged: (val) => controller.key = val,
          ),
          actionWidget:
              MText('搜索', size: 16, onTap: () => controller.onSearch(context)),
        ),
        body: Obx(
          () => MTabPageView(
            key: controller.tabKey,
            tabs: controller.tabs,
            padding: EdgeInsets.zero,
            children: [
              Obx(() => SearchSynthesisPage(
                    // ignore: invalid_use_of_protected_member
                    videoList: controller.videoList.value,
                    user: controller.user.value,
                  )),
              Obx(() => SearchVideoPage(
                    // ignore: invalid_use_of_protected_member
                    videoList: controller.videoList.value,
                  )),
              Obx(() => SearchUserPage(
                    // ignore: invalid_use_of_protected_member
                    userList: controller.userList.value,
                  )),
              VideoGrid(),
            ],
          ),
        ));
  }
}
