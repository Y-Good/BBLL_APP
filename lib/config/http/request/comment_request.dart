import 'package:mvideo/config/http/api/comment_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/utils.dart';

class CommentRequest {
  ///获取评论
  static Future<List<Comment>?> getAllComment(int? videoId) async {
    var json = await HttpUtil.get(CommentApi.comment,
        queryParameters: {'videoId': videoId});
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
  static Future<bool> removeComment(int? commentId) async {
    var json = await HttpUtil.get(CommentApi.removeComment,
        queryParameters: {'commentId': commentId});
    return json == true;
  }

  ///我的评论
  static Future<List<Comment>?> getMyComment() async {
    var json = await HttpUtil.get(
      CommentApi.myComment,
    );
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
      int? videoId, int? parentId, String? content) async {
    var json = await HttpUtil.post(CommentApi.second,
        data: {'videoId': videoId, 'parentId': parentId, 'content': content});
    return Comment.fromJson(json);
  }

  ///huoqu二级
  static Future<List<Comment>?> getSecondComment(int? parentId) async {
    var json = await HttpUtil.get(CommentApi.second,
        queryParameters: {'parentId': parentId});
    if (isNotNull(json)) return getCommentList(json);
    return null;
  }
}
