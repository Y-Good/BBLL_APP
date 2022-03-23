import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/models/common/video.dart';
import 'package:mvideo/models/type/search_type.dart';
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
  String? type;

  onSearch() async {
    if (isNull(key?.trim())) return CommonUtils.toast('请输入关键词');
    // print(tabKey.currentState?.pageIndex);
    switch (tabKey.currentState?.pageIndex) {
      case 1:
        type = SearchType.video;
        break;
      default:
        type = SearchType.user;
        break;
    }
    LoadingUtil.showLoading(msg: '搜索中');
    if (isNotNull(key?.trim())) {
      if (tabKey.currentState?.pageIndex == 0) {
        var findUser = await CommonRequest.searchUser(key!.trim());
        if (findUser != null) user.value = findUser;
      }

      var res = await CommonRequest.getSearch(key!.trim(), type);
      if (type == SearchType.user) {
        userList.value = res as List<User>;
      } else {
        videoList.value = res as List<Video>;
      }
      if (isNull(user) || isNull(res)) return;
    }
    LoadingUtil.dismissLoading();
  }
}
