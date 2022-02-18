import 'package:get/get.dart';
import 'package:mvideo/models/video_model.dart';
import 'package:mvideo/utils/http.dart';

class HomeController extends GetxController {
  // List<Video>? videoList = <Video>[Video(title: "222")].obs;
  final videoList = <Video>[].obs;
  @override
  Future<void> onInit() async {
    var response = await HttpUtil().get(
      '/aip/video',
    );
    print(response);
    videoList.value = Video.fromJson(response['data']);
    super.onInit();
  }

  @override
  void onClose() {}
}
