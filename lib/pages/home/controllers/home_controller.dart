import 'package:get/get.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/public.dart';

class HomeController extends GetxController {
  final videoList = <Video>[].obs;
  final bannerList = <Video>[].obs;

  @override
  Future<void> onInit() async {
    videoList.value = await VideoRequest.getAllVideo() ?? [];
    bannerList.value = await CommonRequest.getBanner() ?? [];
    super.onInit();
  }

  @override
  void onClose() {}
}
