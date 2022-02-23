import 'package:mvideo/config/http/api/video_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/utils.dart';

class VideoRequest {
  ///获取视频
  static Future<List<Video>?> getList() async {
    var json = await HttpUtil().get(VideoApi.video);
    if (isNotNull(json)) {
      return getVideoList(json);
    }
    return null;
  }

  ///获取视频信息
  static Future<Video>? getVideoInfo(int? videoId) async {
    var json = await HttpUtil().get('${VideoApi.video}/$videoId');
    return Video.fromJson(json);
  }
}
