import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/models/common/video.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class SearchController extends GetxController {
  final videoList = <Video>[].obs;
  final user = User().obs;
  final userList = <User>[].obs;
  final tabKey = GlobalKey<MTabPageViewState>();
  String? key;

  onSearch() async {
    if (isNull(key?.trim())) return CommonUtils.toast('请输入关键词');
    // print(tabKey.currentState?.pageIndex);
    LoadingUtil.showLoading(msg: '搜索中');
    if (isNotNull(key?.trim())) {
      user.value = await CommonRequest.searchUser(key!.trim());
      var res = await CommonRequest.getSearch(key!.trim());
      if (tabKey.currentState?.pageIndex == 2) {
        userList.value = res as List<User>;
      } else {
        videoList.value = res as List<Video>;
      }
    }
    LoadingUtil.dismissLoading();
  }
}
