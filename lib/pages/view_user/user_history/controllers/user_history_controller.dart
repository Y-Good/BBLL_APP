import 'package:get/get.dart';
import 'package:mvideo/config/http/request/histroy_request.dart';
import 'package:mvideo/models/common/histroy.dart';

class UserHistoryController extends GetxController {
  final histroyList = <Histroy>[].obs;
  @override
  Future<void> onInit() async {
    histroyList.value = await HistroyRequset.getHistroy() ?? [];
    super.onInit();
  }
}
