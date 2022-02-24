class UserApi {
  ///登录
  static String login = "/user/login";

  ///注册
  static String register = "/user/create";

  ///修改密码
  static String updatePwd = "/user/update.pwd";

  ///关注---Get和Post用同一个字段
  static String follow = "/user/follow";

  ///获取用户信息   传`query`
  static String profile = "/user/profile";
}
