import 'package:get/get.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common/common_utils.dart';

class AccountController extends GetxController {
  String? oldPwd;
  String? newPwd;
  String? validPwd;

  ///修改密码
  onSubmit() async {
    // if (newPwd != validPwd && newPwd != null)
    //   return CommonUtils.toast("两次密码输入不一致");
    // var res = await UserRequest.updatePwd(oldPwd, newPwd);
    // if (res == true) {
    //   CommonUtils.toast("修改成功");
    Get.offNamed(Routes.LOGIN, arguments: {'hiddenLeading': true});
    // }
  }
}
