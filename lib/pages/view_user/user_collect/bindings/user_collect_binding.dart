import 'package:get/get.dart';

import '../controllers/user_collect_controller.dart';

class UserCollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCollectController>(
      () => UserCollectController(),
    );
  }
}
