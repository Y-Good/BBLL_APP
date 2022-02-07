import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/utils/http.dart';
import 'package:mvideo/utils/utils.dart';

class VideoDetailController extends GetxController {
  final like = 33.obs;
  final isLike = false.obs;
  final isText = false.obs;
  final contentController = TextEditingController();
  String? content;
  final contents = [].obs;
  @override
  void onInit() async {
    var res = await HttpUtil().get(
      '/api/comment',
    );
    contents.value = res['data'];
    contentController.addListener(() {
      isText.value = isNotNull(contentController.text);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void submit() {
    print(content);
  }

  void increment() {
    isLike.value ? like.value-- : like.value++;
    isLike.value = !(isLike.value);
  }
}
