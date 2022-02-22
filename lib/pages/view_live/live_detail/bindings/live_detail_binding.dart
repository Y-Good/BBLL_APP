import 'package:get/get.dart';

import '../controllers/live_detail_controller.dart';

class LiveDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveDetailController>(
      () => LiveDetailController(),
    );
  }
}
