import 'package:mvideo/config/http/api/notify_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/notify.dart';

class NotifyRequest {
  static Future<List<Notify>?> getNotify() async {
    var json = await HttpUtil.get(NotifyApi.notify);
    return getNotifyList(json);
  }
}
