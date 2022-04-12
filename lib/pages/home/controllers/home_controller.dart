import 'package:get/get.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/config/http/request/notify_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/user_utils.dart';

class HomeController extends GetxController {
  final videoList = <Video>[].obs;
  final hotList = <Video>[].obs;
  final rankList = <Video>[].obs;
  final bannerList = <Video>[].obs;
  final notifyCount = 0.obs;
  int pageIndex = 0;
  final isLoadingFinsh = false.obs;
  @override
  Future<void> onInit() async {
    NotifyRequest.getNotifyCount();
    LoadingUtil.showLoading();
    bannerList.value = await CommonRequest.getBanner() ?? [];
    videoList.value = await VideoRequest.getAllVideo() ?? [];
    hotList.value = await VideoRequest.hot() ?? [];
    rankList.value = await VideoRequest.rank() ?? [];
    notifyCount.value = UserUtils.getNotifyCount ?? 0;
    LoadingUtil.dismissLoading();
    super.onInit();
  }

  onLoading() async {
    pageIndex++;
    List<Video>? res = await VideoRequest.getAllVideo(pageIndex) ?? [];
    if (res.length == 0) {
      isLoadingFinsh.value = true;
    }
    videoList.addAll(res);
  }

  @override
  void onClose() {}
}
