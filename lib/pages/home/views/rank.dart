import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/public.dart';

class RankPage extends GetView<HomeController> {
  const RankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: DeliveryHeader(),
      onRefresh: () async => print("sss"),
      onLoad: () async => print("急啊在"),
      child: VideoList(
        isShowTip: false,
      ),
    );
  }
}
