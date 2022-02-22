import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/http/api/user_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/utils/utils.dart';

class UserRequest {
  static GetStorage st = GetStorage();

  static userLogin(String? number, String? password) async {
    var params = {'number': number, 'password': password};
    var json = await HttpUtil().post('/user/login', data: params);
    if (isNotNull(json?['token'])) {
      st.write('token', json?['token']);
      Get.back();
    }
  }

  static Future<bool?> userRegister(
      String? number, String? password, String? nickname) async {
    var params = {'number': number, 'password': password, 'nickname': nickname};
    return await HttpUtil().post(UserApi.register, data: params);
  }

  static Future<bool?> updatePwd(String? oldPwd, String? newPwd) async {
    var params = {'oldPwd': oldPwd, 'newPwd': newPwd};
    return await HttpUtil().post(UserApi.updatePwd, data: params);
  }
}
