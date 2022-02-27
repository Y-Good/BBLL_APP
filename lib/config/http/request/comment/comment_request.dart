import 'package:mvideo/config/http/api/comment_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/utils.dart';

class CommentRequest {
  ///获取评论
  static Future<List<Comment>?> getAllComment(int? videoId) async {
    var json = await HttpUtil()
        .get(CommentApi.comment, queryParameters: {'videoId': videoId});
    if (isNotNull(json)) return getCommentList(json);
    return null;
  }

  ///发布评论
  static Future<bool> createComment(int? videoId, String? content) async {
    var json = await HttpUtil().post(CommentApi.comment,
        data: {'videoId': videoId, 'content': content});
    return json == true;
  }

  ///删除评论
  static Future<bool> removeComment(int? commentId) async {
    var json = await HttpUtil().get(CommentApi.removeComment,
        queryParameters: {'commentId': commentId});
    return json == true;
  }

  ///我的评论
  static Future<List<Comment>?> getMyComment() async {
    var json = await HttpUtil()
        .get(CommentApi.myComment, options: CommonUtils.getNewOption());
    return getCommentList(json);
  }
}
