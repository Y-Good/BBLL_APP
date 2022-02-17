import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/public.dart';

class RankPage extends GetView<HomeController> {
  const RankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoList(
      isShowTip: true,
    );
  }
}
