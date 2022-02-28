import 'package:get/get.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/view_user/user_edit/views/user_edit_view.dart';
import 'package:mvideo/utils/user_utils.dart';

class UserEditController extends GetxController {
  User? user;
  String? nickname;
  String? gg;
  List<MFormItem> get test => [
        MFormItem(label: "昵称", text: user?.nickname, value: nickname),
        // MFormItem(label: "dddd", text: user?.nickname, value: gg),
      ];

  @override
  void onInit() {
    user = UserUtils.getUser;
    super.onInit();
  }

  onSubmit() {
    UserRequest.updateUser(nickname);
    Get.back();
  }
}
