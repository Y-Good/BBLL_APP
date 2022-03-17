import 'package:mvideo/config/http/api/colloect_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/collect.dart';

class CollectRequest {
  ///创建
  static Future<bool>? createColloect({int? videoId, int? followId}) async {
    var json = await HttpUtil.get(CollectApi.collect,
        queryParameters: {'videoId': videoId, 'followId': followId});
    return json;
  }

  ///李彪
  static Future<List<Collect>?> getCollect(String type) async {
    var json =
        await HttpUtil.get(CollectApi.list, queryParameters: {'type': type});
    return getCollectList(json);
  }
}
