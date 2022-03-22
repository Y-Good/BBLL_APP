import 'package:mvideo/config/http/api/common_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/tag.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/models/common/video.dart';
import 'package:mvideo/models/type/search_type.dart';

class CommonRequest {
  ///轮播图
  static Future<List<Video>?> getBanner() async {
    var json = await HttpUtil.get(CommonApi.banner);
    return getVideoList(json);
  }

  static Future<List<Tag>?> getTag() async {
    var json = await HttpUtil.get(CommonApi.tag);
    return getTagList(json);
  }

  static Future<List<Object>> getSearch(String key, [String? type]) async {
    var json = await HttpUtil.get(CommonApi.search,
        queryParameters: {'key': key, 'type': type});

    // ///视频
    if (type == SearchType.video) {
      return getVideoList(json);
    }

    ///用户
    if (type == SearchType.user) {
      return getUserList(json);
    }
    return getVideoList(json);
  }

  static Future<User> searchUser(String key, {String? type}) async {
    var json =
        await HttpUtil.get(CommonApi.searchUser, queryParameters: {'key': key});
    return User.fromJson(json);
  }
}
