import 'package:get/get.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/models/public.dart';

class HomeController extends GetxController {
  final videoList = <Video>[].obs;
  @override
  Future<void> onInit() async {
    videoList.value = await VideoRequest.getAllVideo() ?? [];
    super.onInit();
  }

  @override
  void onClose() {}
}
