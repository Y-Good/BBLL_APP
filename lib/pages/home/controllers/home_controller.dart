import 'package:get/get.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/config/http/request/notify_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/user_utils.dart';

class HomeController extends GetxController {
  final videoList = <Video>[].obs;
  final bannerList = <Video>[].obs;
  final notifyCount = 0.obs;

  @override
  Future<void> onInit() async {
    NotifyRequest.getNotifyCount();
    LoadingUtil.showLoading();
    videoList.value = await VideoRequest.getAllVideo() ?? [];
    bannerList.value = await CommonRequest.getBanner() ?? [];
    notifyCount.value = UserUtils.getNotifyCount;
    LoadingUtil.dismissLoading();
    super.onInit();
  }

  @override
  void onClose() {}
}
