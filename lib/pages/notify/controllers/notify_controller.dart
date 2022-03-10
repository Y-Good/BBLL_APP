import 'package:get/get.dart';
import 'package:mvideo/config/http/request/notify_request.dart';
import 'package:mvideo/models/common/notify.dart';

class NotifyController extends GetxController {
  final notifyList = <Notify>[].obs;

  @override
  Future<void> onInit() async {
    notifyList.value = await NotifyRequest.getNotify() ?? [];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
