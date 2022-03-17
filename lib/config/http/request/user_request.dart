import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/http/api/file_api.dart';
import 'package:mvideo/config/http/api/user_api.dart';
import 'package:mvideo/config/http/http.dart';
import 'package:mvideo/models/common/user.dart';
import 'package:mvideo/pages/public.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

class UserRequest {
  static GetStorage _st = GetStorage();
  static UserController _userController = Get.put(UserController());

  static Future<bool> userLogin(String? number, String? password) async {
    var params = {'number': number, 'password': password};
    var json = await HttpUtil.post(UserApi.login, data: params);
    if (isNotNull(json?['token'])) {
      UserUtils.saveToken(json?['token']);
      _userController.isLogin.value = isNull(_st.read('token'));
      return true;
    }
    return false;
  }

  static Future<bool?> userRegister(
      String? number, String? password, String? nickname) async {
    var params = {'number': number, 'password': password, 'nickname': nickname};
    return await HttpUtil.post(UserApi.register, data: params);
  }

  static Future<bool?> updatePwd(String? oldPwd, String? newPwd) async {
    var params = {'oldPwd': oldPwd, 'newPwd': newPwd};
    return await HttpUtil.post(UserApi.updatePwd, data: params);
  }

  /* 获取用户信息 */
  static Future<User?> getUserInfo({int? userId}) async {
    var params = {"userId": userId};
    var json = await HttpUtil.get(
      UserApi.profile,
      queryParameters: isNotNull(userId) ? params : null,
    );
    if (isNotNull(json)) {
      if (isNull(userId)) {
        ///存一下
        UserUtils.saveUserInfo(User.fromJson(json));
      }
      return User.fromJson(json);
    }
    return null;
  }

  /* 更新信息 */
  static void updateUser(String? nickname) async {
    var params = {'nickname': nickname};
    var json = await HttpUtil.post(
      UserApi.update,
      data: params,
      // options: CommonUtils.getNewOption(),
    );
    UserUtils.saveUserInfo(User.fromJson(json));
  }

  ///上传
  static void uploadAvatar(FormData params) async {
    var json = await HttpUtil.post(
      FileApi.upload,
      data: params,
    );
    UserUtils.saveUserInfo(User.fromJson(json));
  }
}
