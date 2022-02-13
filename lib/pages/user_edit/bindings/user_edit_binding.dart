import 'package:get/get.dart';

import '../controllers/user_edit_controller.dart';

class UserEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserEditController>(
      () => UserEditController(),
    );
  }
}
