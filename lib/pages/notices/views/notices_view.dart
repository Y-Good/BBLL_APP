import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/notices_controller.dart';

class NoticesView extends GetView<NoticesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MColors.background,
        appBar: MAppBar(
          title: "通知",
        ),
        body: SingleChildScrollView(
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (_, index) => Container(
              color: MColors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: MAvatar(
                      "https://img1.baidu.com/it/u=2716398045,2043787292&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800",
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MText('大叔控'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: index % 2 == 0
                                ? Icon(
                                    IconFonts.iconDianzan2,
                                    size: 18,
                                    color: MColors.primiaryColor,
                                  )
                                : Text(
                                    "是否打实啊实打实",
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ),
                          MText(
                            "13:22",
                            size: 12,
                            color: MColors.grey6,
                          )
                        ],
                      ),
                    ),
                  ),
                  MAvatar(
                    'https://img2.baidu.com/it/u=2182014426,2379325530&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                    width: 64,
                    height: 64,
                    radius: 0,
                  )
                ],
              ),
            ),
            separatorBuilder: (_, index) => Divider(
              height: .5,
              color: Colors.grey[300],
            ),
          ),
        ));
  }
}
