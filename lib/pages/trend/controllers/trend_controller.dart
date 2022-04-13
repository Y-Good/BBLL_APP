import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/http/request/collect_request.dart';
import 'package:mvideo/models/common/trend.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';

class TrendController extends GetxController {
  final trendList = <Trend>[].obs;
  bool get isUser => UserUtils.hasToken;
  @override
  void onInit() async {
    trendList.value = await CollectRequest.getTrend() ?? [];
    super.onInit();
  }

  void onSelectTime(int day) async {
    trendList.value = await CollectRequest.getTrend(day: day) ?? [];
  }

  void onMenu() {
    Map<String, VoidCallback> sheet = {
      '三天内': () => onSelectTime(3),
      '一周内': () => onSelectTime(7)
    };
    CommonUtils.mActionSheet(sheet, onCancel: () => onInit());
  }
}
