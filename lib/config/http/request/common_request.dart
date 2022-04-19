import 'package:mvideo/config/http/api/common_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/room.dart';
import 'package:mvideo/models/common/tag.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/models/common/video.dart';
import 'package:mvideo/models/type/search_type.dart';
import 'package:mvideo/utils/utils.dart';

class CommonRequest {
  ///轮播图
  static Future<List<Video>?> getBanner() async {
    var json = await HttpUtil.get(CommonApi.banner);
    if (json != null) return getVideoList(json);
    return null;
  }

  static Future<List<Tag>?> getTag() async {
    var json = await HttpUtil.get(CommonApi.tag);
    if (json != null) return getTagList(json);
    return null;
  }

  static Future<List<Video>?> getVideoByTag(int tagId) async {
    var json = await HttpUtil.get(CommonApi.tagVideo,
        queryParameters: {'tagId': tagId});
    return getVideoList(json);
  }

  static Future<List<Object>?> getSearch(String key, [String? type]) async {
    var params = {'key': key, 'type': type};
    params.removeWhere((key, value) => value == null);
    var json = await HttpUtil.get(CommonApi.search, queryParameters: params);
    if (isNull(json)) return null;
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

  static Future<User?> searchUser(String key) async {
    var params = {'key': key};
    var json =
        await HttpUtil.get(CommonApi.searchUser, queryParameters: params);
    if (isNull(json)) return null;

    return User.fromJson(json);
  }

  //创建标签
  static Future<Tag> createTag(String tag) async {
    var json = await HttpUtil.post(CommonApi.tag, data: {'tag': tag});
    return Tag.fromJson(json);
  }

  //在线房间
  static Future<List<Room>?> getOnline() async {
    var json = await HttpUtil.get(CommonApi.room);
    return getRoomList(json);
  }
}
