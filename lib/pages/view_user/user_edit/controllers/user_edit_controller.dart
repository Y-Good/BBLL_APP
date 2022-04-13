import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/http/request/user_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/view_user/user_edit/views/user_edit_view.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';

class UserEditController extends GetxController {
  Rx<User?> get user => UserUtils.getUser.obs;
  RxString imgPath = ''.obs;
  FormData? formdata;

  final params = <String, dynamic>{}.obs;

  List<MFormItem> get uForm => [
        MFormItem(
          key: 'nickname',
          label: "昵称",
          value: user.value?.nickname,
        ),
        MFormItem(
          key: 'gender',
          label: "性别",
          value: user.value?.gender.toString(),
          type: MFormType.gender,
        ),
        MFormItem(key: 'mobile', label: '手机', value: user.value?.mobile),
        MFormItem(
          key: 'birthday',
          label: '生日',
          value: user.value?.birthday,
          type: MFormType.date,
        ),
        MFormItem(key: 'signature', label: '签名', value: user.value?.signature),
      ].obs;

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

  onSubmit() async {
    if (formdata != null) {
      var res = await UserRequest.uploadAvatar(formdata!);
      Get.back(result: {'avatar': res.avatar});
    }
    if (isNotNull(params)) {
      var res = await UserRequest.updateUser(params);
      if (res != null) {
        CommonUtils.toast('修改成功');
        Get.back();
      }
    }
  }
}
