import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/public.dart';

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => VideoList(
        // ignore: invalid_use_of_protected_member
        videoList: controller.rankList.value,
        isShowTip: false,
      ),
    );
  }
}
