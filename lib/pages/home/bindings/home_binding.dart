import 'package:get/get.dart';
import 'package:mvideo/common/controllers/refresh_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<RefreshController>(() => RefreshController(),
        tag: 'home', fenix: true);
    Get.lazyPut<RefreshController>(() => RefreshController(),
        tag: 'trend', fenix: true);
  }
}
