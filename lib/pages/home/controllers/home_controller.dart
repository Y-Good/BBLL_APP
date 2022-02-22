import 'package:get/get.dart';
import 'package:mvideo/models/video_model.dart';
import 'package:mvideo/config/http/http.dart';

class HomeController extends GetxController {
  // List<Video>? videoList = <Video>[Video(title: "222")].obs;
  final videoList =
      <Video>[Video(id: 1, title: '测试', author: '测试', views: 222)].obs;
  @override
  Future<void> onInit() async {
    var response = await HttpUtil().get(
      '/aip/video',
    );

    videoList.addAll(Video.fromJson(response['data']));
    super.onInit();
  }

  @override
  void onClose() {}
}
