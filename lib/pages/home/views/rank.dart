import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
