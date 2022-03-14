import 'package:mvideo/config/http/api/notify_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/notify.dart';
import 'package:mvideo/utils/user_utils.dart';

class NotifyRequest {
  static Future<List<Notify>?> getNotify() async {
    var json = await HttpUtil.get(NotifyApi.notify);
    return getNotifyList(json);
  }

  ///获取未读
  static Future<void> getNotifyCount() async {
    var json = await HttpUtil.get(NotifyApi.unread);
    UserUtils.saveNotifyCount(json as int);
  }

  ///全部标记
  static Future<void> markNotify() async {
    HttpUtil.get(NotifyApi.mark);
  }
}
