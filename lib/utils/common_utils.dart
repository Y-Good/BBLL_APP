import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:intl/intl.dart';

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
  static Future<bool?> dialog(
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

  ///处理资源地址
  static String handleSrcUrl(String src) {
    if (isNull(src)) return Server.resources;
    return '${Server.resources}$src';
  }

  /// 时间格式化，返回字符串，默认格式：2019-01-01
  static String? format(DateTime? date, [String format = 'yyyy-MM-dd']) {
    try {
      if (date == null) return "时间错误";
      return DateFormat(format).format(date);
    } catch (e) {
      return null;
    }
  }

  ///处理时间
  static String? remindTime(String? date) {
    try {
      DateTime now = new DateTime.now();
      DateTime? end = DateTime.tryParse(date ?? '');
      if (end == null) return "时间错误";
      // end = end.add(Duration(seconds: 0));
      if (end.isAfter(now)) return "刚刚";
      if (now.year > end.year) return format(end);
      var diff = now.difference(end);
      if (diff.inDays > 7) return '${format(end, "MM-dd")}';
      if (diff.inDays > 0) return '${diff.inDays}天前';
      if (diff.inHours > 0) return '${diff.inHours}小时前';
      if (diff.inMinutes > 0) return '${diff.inMinutes}分钟前';
      return "刚刚";
    } catch (e) {
      return null;
    }
  }

  static void mActionSheeet(Map<String, VoidCallback> sheet,
      {VoidCallback? onCancel}) {
    List<Widget> sheetList = [];
    sheet.forEach((key, value) {
      sheetList.add(
        InkWell(
          onTap: () {
            value();
            Get.back();
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: MColors.background, width: .5),
              ),
            ),
            child: MText(key),
          ),
        ),
      );
    });

    Get.bottomSheet(
      Container(
        height: 56 + sheet.length * 50,
        child: Column(
          children: [
            ...sheetList,
            Container(
              height: 6,
              color: MColors.background,
            ),
            InkWell(
              onTap: () {
                if (isNotNull(onCancel)) {
                  onCancel!();
                }
                Get.back();
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: MText("取消"),
              ),
            )
          ],
        ),
      ),
      enableDrag: false,
      backgroundColor: Colors.white,
    );
  }
}
