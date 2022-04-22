import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/collect_request.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/models/common/video.dart';
import 'package:mvideo/models/type/search_type.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class SearchController extends GetxController {
  final videoList = <Video>[].obs;
  final user = User().obs;
  final userList = <User>[].obs;
  final tabKey = GlobalKey<MTabPageViewState>();
  final isFollow = false.obs;
  String? key;
  String? type;

  List<String> tabText = ['综合', '视频', '用户', '直播'];
  List<int> get tabInt => [
        0,
        videoList.length,
        userList.length,
        0,
      ];
  RxList<Widget> get tabs => List.generate(
      tabText.length,
      (index) => MBadge(
            value: tabInt[index],
            hidden: tabInt[index] == 0,
            child: Tab(
              text: tabText[index],
              height: 36,
            ),
          )).obs;

  onSearch(BuildContext context) async {
    user.value = User();
    videoList.value = [];
    userList.value = [];
    if (isNull(key?.trim())) return CommonUtils.toast('请输入关键词');
    FocusScope.of(context).requestFocus(FocusNode());
    LoadingUtil.showLoading(msg: '搜索中');
    if (isNotNull(key?.trim())) {
      var findUser = await CommonRequest.searchUser(key!.trim());
      if (findUser != null) {
        user.value = findUser;
        isFollow.value = user.value.isFollow ?? false;
      }

      var resV = await CommonRequest.getSearch(key!.trim(), SearchType.video);
      var resU = await CommonRequest.getSearch(key!.trim(), SearchType.user);
      if (isNull(resV) && isNull(resU) && isNull(user.value.id)) {
        LoadingUtil.dismissLoading();
        return CommonUtils.toast('没有搜索到结果');
      }

      if (isNotNull(resU)) userList.value = resU as List<User>;

      if (isNotNull(resV)) videoList.value = resV as List<Video>;
    }
    LoadingUtil.dismissLoading();
  }

  void cancelFollow(int? followId, {int? index}) async {
    if (UserUtils.hasToken == false) return CommonUtils.toast('请先登录APP');
    var dialog = await CommonUtils.dialog('您确定取消关注吗？');
    if (dialog == true) {
      if (index != null) {
        userList[index].isFollow = !(userList[index].isFollow!);
        userList.refresh();
      } else {
        isFollow.value = !isFollow.value;
      }
      CollectRequest.createColloect(followId: followId);
    }
  }

  ///关注滴干活
  void onFollow(int? userId, {int? index}) {
    if (UserUtils.hasToken == false) return CommonUtils.toast('请先登录APP');
    CommonUtils.toast(isFollow.value ? '取消关注' : '关注成功');
    if (index != null) {
      userList[index].isFollow = !(userList[index].isFollow!);
      userList.refresh();
    } else {
      isFollow.value = !isFollow.value;
    }
    CollectRequest.createColloect(followId: userId);
  }
}
