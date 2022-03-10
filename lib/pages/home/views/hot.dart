import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/public.dart';

class HotPage extends StatefulWidget {
  const HotPage({Key? key}) : super(key: key);

  @override
  State<HotPage> createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VideoList();
  }
}
