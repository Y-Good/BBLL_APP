import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
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
          elevation: 0,
          backgroundColor: MColors.blackBackground,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
                left: 0,
                top: 32,
                child: MText(
                  '发现',
                  size: 32,
                  color: MColors.white,
                )),
            // Positioned(
            //     top: 96,
            //     width: Get.width,
            //     height: 64,
            //     child: Center(
            //       child: Swiper(
            //         scrollDirection: Axis.vertical,
            //         itemBuilder: ((context, index) => MListTile(
            //               title: '加入房间',
            //               titleColor: Colors.white,
            //             )),
            //         itemCount: 2,
            //       ),
            //     )),
            Positioned(
                width: 80,
                height: 80,
                bottom: 100,
                child: GestureDetector(
                  onTap: controller.onGetRoom,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFf81ffef),
                          Color(0xFFff7676),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ))
          ]),
        ));
  }
}
