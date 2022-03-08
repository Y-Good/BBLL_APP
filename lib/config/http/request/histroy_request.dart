import 'package:mvideo/config/http/api/histroy_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/histroy.dart';

class HistroyRequset {
  static Future<List<Histroy>?> getHistroy() async {
    var json = await HttpUtil.get(HistroyApi.histroy);
    return getHistroyList(json);
  }

  static void createHistroy(int? videoId) {
    HttpUtil.post(HistroyApi.histroy, queryParameters: {'videoId': videoId});
  }
}
