import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/user_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class CommonUtils {
  CommonUtils._();

  ///提示
  static void toast(String msg) {
    OverlayEntry? entry;
    Widget widget = Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: MText(msg, color: Colors.white),
        ),
      ),
    );
    entry?.remove();
    entry = null;
    entry = OverlayEntry(
      builder: (_) => widget,
    );

    Overlay.of(Get.overlayContext!)?.insert(entry);

    Timer(const Duration(seconds: 2), () {
      entry?.remove();
    });
  }

  ///性别 0未知,1男,2女
  static List<String> get gender => ["未知", "男", "女"];
  static String? getGender(int? data) {
    if (![0, 1, 2].contains(data)) return null;
    return gender[data!];
  }

  ////dialog
  static Future<bool> dialog(
    String? text, {
    String? textCancel,
    String? textConfirm,
  }) async {
    return await Get.defaultDialog(
      title: '提示',
      middleText: text ?? '',
      cancel: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: MButton(
          width: 80,
          height: 36,
          label: textCancel ?? '取消',
          bgColor: MColors.grey9.withOpacity(0.8),
          onTap: () => Get.back(result: false),
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: MButton(
            width: 80,
            height: 36,
            label: textConfirm ?? '确认',
            onTap: () => Get.back(result: true)),
      ),
      radius: 10,
    );
  }

  ///请求头
  static Options getNewOption() {
    Options options = new Options(
      headers: isNotNull(UserUtils.getToken())
          ? {'Authorization': 'Bearer ${UserUtils.getToken()}'}
          : null,
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    return options;
  }

  ///处理资源地址
  static String handleSrcUrl(String src) {
    if (isNull(src)) return '';
    return '${Server.resources}/$src';
  }
}
