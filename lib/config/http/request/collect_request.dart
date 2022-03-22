import 'package:mvideo/config/http/api/collect_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/collect.dart';
import 'package:mvideo/models/common/trend.dart';

class CollectRequest {
  ///创建
  static Future<bool?> createColloect({int? videoId, int? followId}) async {
    var json = await HttpUtil.get(CollectApi.collect,
        queryParameters: {'videoId': videoId, 'followId': followId});
    return json;
  }

  ///李彪
  static Future<List<Collect>?> getCollect(String type, {int? userId}) async {
    var params = {'type': type, 'userId': userId};
    params.removeWhere((key, value) => value == null);
    var json = await HttpUtil.get(CollectApi.list, queryParameters: params);
    return getCollectList(json);
  }

  ///动态李彪
  static Future<List<Trend>?> getTrend({int? day}) async {
    var params = {'day': day};
    params.removeWhere((key, value) => value == null);
    var json = await HttpUtil.get(CollectApi.trend, queryParameters: params);
    return getTrendList(json);
  }

  ///是否关注
  static Future<bool?> isFollow(int? followId) async {
    var params = {'followId': followId};
    var json = await HttpUtil.get(CollectApi.isFollow, queryParameters: params);
    return json;
  }
}
