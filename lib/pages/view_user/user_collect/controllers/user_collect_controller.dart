import 'package:get/get.dart';
import 'package:mvideo/config/http/request/colloect_request.dart';
import 'package:mvideo/models/common/collect.dart';
import 'package:mvideo/models/type/collect_type.dart';

class UserCollectController extends GetxController {
  final collectList = <Collect>[].obs;
  @override
  void onInit() async {
    collectList.value =
        await CollectRequest.getCollect(CollectType.video) ?? [];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
