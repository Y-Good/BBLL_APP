import 'package:get/get.dart';
import 'package:mvideo/config/http/request/notify_request.dart';
import 'package:mvideo/models/common/notify.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/utils/user_utils.dart';

class NotifyController extends GetxController {
  final notifyList = <Notify>[].obs;
  HomeController homeController = Get.find<HomeController>();

  @override
  Future<void> onInit() async {
    notifyList.value = await NotifyRequest.getNotify() ?? [];
    NotifyRequest.markNotify();
    homeController.notifyCount.value = 0;
    UserUtils.saveNotifyCount(0);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
