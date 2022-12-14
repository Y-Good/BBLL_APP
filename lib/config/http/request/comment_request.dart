import 'package:mvideo/config/http/api/comment_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

class CommentRequest {
  ///获取评论
  static Future<List<Comment>?> getAllComment(int? videoId,
      [int? userId]) async {
    var params = {'videoId': videoId, 'userId': userId};
    params.removeWhere((key, value) => value == null);
    var json = await HttpUtil.get(CommentApi.comment, queryParameters: params);
    if (isNotNull(json)) return getCommentList(json);
    return null;
  }

  ///发布评论
  static Future<Comment>? createComment(int? videoId, String? content) async {
    var json = await HttpUtil.post(CommentApi.comment,
        data: {'videoId': videoId, 'content': content});
    return Comment.fromJson(json);
  }

  ///删除评论
  static Future<bool> removeComment(int? commentId, [int? parentId]) async {
    var params = {'commentId': commentId, 'parentId': parentId};
    params.removeWhere((key, value) => value == null);
    var json =
        await HttpUtil.get(CommentApi.removeComment, queryParameters: params);
    return json == true;
  }

  ///我的评论
  static Future<List<Comment>?> getMyComment(int? userId) async {
    var params = {'userId': userId};
    params.removeWhere((key, value) => value == null);
    var json =
        await HttpUtil.get(CommentApi.myComment, queryParameters: params);
    return getCommentList(json);
  }

  ///我是不是点了
  static Future<bool?> isThumbUp() async {
    var json = await HttpUtil.get(
      CommentApi.isThumbUp,
    );
    return json;
  }

  ///点赞
  static Future<bool?> thumbUp(int? commentId) async {
    var json = await HttpUtil.get(CommentApi.thumbUp,
        queryParameters: {'commentId': commentId});
    return json;
  }

  ///创建erji
  static Future<Comment>? createSecond(
    int? videoId,
    int? parentId,
    String? content,
    int? replayUserId,
  ) async {
    var params = {
      'videoId': videoId,
      'parentId': parentId,
      'content': content,
      'replayUserId': replayUserId
    };
    var json = await HttpUtil.post(CommentApi.second, data: params);
    return Comment.fromJson(json);
  }

  ///huoqu二级
  static Future<List<Comment>?> getSecondComment(int? parentId) async {
    var params = {'parentId': parentId, 'userId': UserUtils.getUser?.id};
    params.removeWhere((key, value) => value == null);
    var json = await HttpUtil.get(CommentApi.second, queryParameters: params);
    if (isNotNull(json)) return getCommentList(json);
    return null;
  }
}
