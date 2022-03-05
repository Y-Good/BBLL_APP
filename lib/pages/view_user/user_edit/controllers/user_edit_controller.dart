import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/view_user/user_edit/views/user_edit_view.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';

class UserEditController extends GetxController {
  Rx<User?> get user => UserUtils.getUser.obs;
  RxString imgPath = ''.obs;

  FormData? formdata;
  String? nickname;

  List<MFormItem> get test => [
        MFormItem(label: "昵称", text: user.value?.nickname),
        MFormItem(label: "性别", text: CommonUtils.getGender(user.value?.gender)),
        MFormItem(label: '手机', text: user.value?.mobile),
        MFormItem(label: '生日', text: user.value?.birthday),
        MFormItem(label: '签名', text: user.value?.signature),
      ];

  @override
  void onInit() {
    super.onInit();
  }

  void imagePick(ImageSource? pickType) async {
    if (Get.isBottomSheetOpen == true) Get.close(0);
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: pickType ?? ImageSource.gallery, imageQuality: 70);

    if (image != null) {
      imgPath.value = image.path;
      formdata = FormData.fromMap({
        "avatar":
            await MultipartFile.fromFile(image.path, filename: image.name),
      });
    }
  }

  onSubmit() {
    if (formdata != null) {
      UserRequest.uploadAvatar(formdata!);
    }
    // UserRequest.updateUser(nickname);
    Get.back(result: {'avatar': UserUtils.getUser?.avatar});
  }
}
