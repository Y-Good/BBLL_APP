import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}
