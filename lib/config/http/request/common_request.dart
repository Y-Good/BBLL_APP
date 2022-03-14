import 'package:mvideo/config/http/api/comment_api.dart';
import 'package:mvideo/config/http/api/common_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/tag.dart';
import 'package:mvideo/models/common/video.dart';

class CommonRequest {
  ///轮播图
  static Future<List<Video>?> getBanner() async {
    var json = await HttpUtil.get(CommonApi.banner);
    return getVideoList(json);
  }

  static Future<List<Tag>?> getTag() async {
    var json = await HttpUtil.get(CommentApi.tag);
    return getTagList(json);
  }
}
