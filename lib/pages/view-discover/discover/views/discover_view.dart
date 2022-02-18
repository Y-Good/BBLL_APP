import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MColors.blackBackground,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MColors.blackBackground,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
                left: 0,
                top: 16,
                child: MText(
                  '发现',
                  size: 30,
                  color: MColors.white,
                )),
            Positioned(
                width: 100,
                height: 100,
                bottom: 100,
                child: MAvatar(
                  'https://img1.baidu.com/it/u=1822384944,1157459425&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=400',
                  height: 100,
                  width: 100,
                  onTap: () => Get.toNamed(Routes.DISCOVER_DETAIL),
                ))
          ]),
        ));
  }
}
