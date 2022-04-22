import 'package:get/get.dart';
import 'package:mvideo/config/http/request/histroy_request.dart';
import 'package:mvideo/models/common/histroy.dart';
import 'package:mvideo/utils/loading_util.dart';

class UserHistoryController extends GetxController {
  final histroyList = <Histroy>[].obs;
  @override
  Future<void> onInit() async {
    LoadingUtil.showLoading();
    histroyList.value = await HistroyRequset.getHistroy() ?? [];
    LoadingUtil.dismissLoading();
    super.onInit();
  }

  // Future<void> delHistroy(int histroyId) async {
  //   bool res = await HistroyRequset.delHistroy(histroyId) ?? false;
  // }
}
