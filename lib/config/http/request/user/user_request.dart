import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/http/api/user_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/pages/public.dart';
import 'package:mvideo/utils/utils.dart';

class UserRequest {
  static GetStorage _st = GetStorage();
  static UserController _userController = Get.put(UserController());

  static Future<bool> userLogin(String? number, String? password) async {
    var params = {'number': number, 'password': password};
    var json = await HttpUtil().post(UserApi.login, data: params);
    if (isNotNull(json?['token'])) {
      _st.write('token', json?['token']);
      _userController.isLogin.value = isNull(_st.read('token'));
      return true;
    }
    return false;
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

  ///关注
  static Future<List<User>?> getFollowList() async {
    var json = await HttpUtil().get(UserApi.follow);
    return User.fromJson(json).follows;
  }

  ///创建、取消
  static Future<bool>? updateFollow(int? followId) async {
    return await HttpUtil().post(UserApi.follow, data: {'followId': followId});
    // return User.fromJson(json).follows;
  }

  /* 获取用户信息 */
  static Future<User?> getUserInfo({int? userId}) async {
    var params = {"userId": userId};
    var json = await HttpUtil().get(UserApi.profile,
        queryParameters: isNotNull(userId) ? params : null);
    if (isNotNull(json)) {
      if (isNull(userId)) {
        ///存一下
        _st.write('user', User.fromJson(json));
      }
      return User.fromJson(json);
    }
    return null;
  }
}
