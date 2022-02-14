import 'package:get/get.dart';

import '../controllers/user_zone_controller.dart';

class UserZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserZoneController>(
      () => UserZoneController(),
    );
  }
}
