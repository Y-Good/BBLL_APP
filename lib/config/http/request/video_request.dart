import 'package:dio/dio.dart';
import 'package:mvideo/config/http/api/file_api.dart';
import 'package:mvideo/config/http/api/video_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/utils.dart';

class VideoRequest {
  ///获取视频
  static Future<List<Video>?> getAllVideo() async {
    var json = await HttpUtil.get(VideoApi.video);
    if (isNotNull(json)) {
      return getVideoList(json);
    }
    return null;
  }

  ///获取视频信息
  static Future<Video>? getVideoInfo(int? videoId) async {
    var json = await HttpUtil.get(VideoApi.video,
        queryParameters: {'videoId': videoId});
    return Video.fromJson(json);
  }

  ///wode视频
  static Future<List<Video>?> getMyVideo() async {
    var json = await HttpUtil.get(
      VideoApi.myVideo,
    );
    return getVideoList(json);
  }

  ///上传视频
  static Future<bool>? uploadVideo(FormData params) async {
    var json = await HttpUtil.post(FileApi.upload, data: params);
    return json != null;
  }
}
