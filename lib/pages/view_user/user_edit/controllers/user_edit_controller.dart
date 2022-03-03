import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/http/request/user/user_request.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/upload/controllers/upload_controller.dart';
import 'package:mvideo/pages/view_user/user_edit/views/user_edit_view.dart';
import 'package:mvideo/utils/user_utils.dart';

class UserEditController extends GetxController {
  Rx<User?> get user => UserUtils.getUser.obs;
  String? nickname;
  String? gg;
  List<MFormItem> get test => [
        MFormItem(
            label: "昵称",
            text: user.value?.nickname,
            value: user.value?.nickname),
        // MFormItem(label: "dddd", text: user?.nickname, value: gg),
      ];
  final List<PickItem> pickList = [
    PickItem(icon: Icons.photo, label: '相册 ', pickType: ImageSource.gallery),
    PickItem(icon: Icons.camera, label: '相机  ', pickType: ImageSource.camera)
  ];
  @override
  void onInit() {
    super.onInit();
  }

  void imagePick(ImageSource? pickType) async {
    if (Get.isBottomSheetOpen == true) Get.close(0);
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: pickType ?? ImageSource.gallery);
    if (image != null) {
      FormData formdata = FormData.fromMap({
        "avatar":
            await MultipartFile.fromFile(image.path, filename: image.name),
      });
      UserRequest.uploadAvatar(formdata);
    }
  }

  onSubmit() {
    UserRequest.updateUser(nickname);
    Get.back();
  }
}
