import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/widgets/public.dart';

class CommonUtils {
  CommonUtils._();

  ///提示
  static void toast() {
    Widget widget = Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: MText("消息测试", color: Colors.white),
        ),
      ),
    );
    var entry = OverlayEntry(
      builder: (_) => widget,
    );

    Overlay.of(Get.overlayContext!)?.insert(entry);

    Timer(const Duration(seconds: 2), () {
      entry.remove();
    });
  }
}
