import 'package:mvideo/config/http/api/common_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/video.dart';

class CommonRequest {
  ///轮播图
  static Future<List<Video>?> getBanner() async {
    var json = await HttpUtil.get(CommonApi.banner);
    return getVideoList(json);
  }
}
