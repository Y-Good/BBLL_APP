import 'package:get/get.dart';

import '../controllers/discover_detail_controller.dart';

class DiscoverDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscoverDetailController>(
      () => DiscoverDetailController(),
    );
  }
}
