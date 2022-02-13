import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/widgets/public.dart';

class RankPage extends GetView<HomeController> {
  const RankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://img0.baidu.com/it/u=3946988278,2221342011&fm=26&fmt=auto'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 30),
                child: Row(
                  children: [
                    Image.network(
                      'https://img0.baidu.com/it/u=3946988278,2221342011&fm=26&fmt=auto',
                      fit: BoxFit.cover,
                      width: Get.width / 3,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MText(
                              "页面中间的加载框，可以配置显示的文字。",
                              color: Colors.white,
                              maxLines: 5,
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MText(
                                  "倔强的小强",
                                  color: MColors.grey9,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [MText("text"), MText("text")],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }
}
