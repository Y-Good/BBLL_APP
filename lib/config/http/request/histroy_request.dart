import 'package:mvideo/config/http/api/histroy_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/histroy.dart';

class HistroyRequset {
  static Future<List<Histroy>?> getHistroy() async {
    var json = await HttpUtil.get(HistroyApi.histroy);
    if (json != null) return getHistroyList(json);
    return null;
  }

  static void createHistroy(int? videoId) {
    HttpUtil.post(HistroyApi.histroy, queryParameters: {'videoId': videoId});
  }

  static Future<bool?> delHistroy(int? histroyId) async {
    return await HttpUtil.post(HistroyApi.histroy,
        queryParameters: {'histroyId': histroyId});
  }
}
