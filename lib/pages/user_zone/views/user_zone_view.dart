import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/user_zone_controller.dart';

class UserZoneView extends GetView<UserZoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MAppBar(actionWidget: MIcon(IconFonts.iconSousuo)),
        body: Container(
            width: double.infinity,
            color: Colors.white,
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 82,
                    width: 82,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img2.baidu.com/it/u=3782522808,1589825680&fm=26&fmt=auto'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("data"),
                    SizedBox(width: 48),
                    Text("123"),
                  ],
                ),
                SizedBox(height: 30),
                Flexible(
                  child: MTabPageView(
                      initialIndex: 1,
                      tabs: controller.tabs,
                      children: [
                        userFollow(),
                        userVideo(),
                        userComment(),
                      ]),
                )
              ],
            )));
  }

  Widget userVideo() {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: VideoList(
            // ignore: invalid_use_of_protected_member
            videoList: controller.videoList.value,
          ),
        ));
  }

  Widget userFollow() {
    return Container(
        padding: EdgeInsets.only(top: 8),
        child: ListView.separated(
            itemBuilder: (_, index) => MListTile(
                  url:
                      'https://img2.baidu.com/it/u=1052567076,3275246168&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
                  title: '我的姓还是快点回家咯撒',
                  subtitle: '了了了了了了',
                  trailing: MButton(
                    label: '已关注',
                    height: 32,
                    bgColor: Colors.grey,
                    width: 64,
                  ),
                ),
            itemCount: 5,
            separatorBuilder: (_, index) => Divider(
                  height: .5,
                  color: Colors.grey[300],
                )));
  }

  Widget userComment() {
    return ListView.separated(
        itemBuilder: (_, index) {
          return Column(
            children: [
              MListTile(
                url:
                    'https://img2.baidu.com/it/u=1052567076,3275246168&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
                title: '绝情小王子',
                subtitle: '2020-01-23\t\t13:44',
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                alignment: Alignment.centerLeft,
                child: MText('宁可输给强大的敌人，不要输给失控的自己。'),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                    color: MColors.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MText(
                          '每个人都有属于自己的舞台，这个舞台，是那么光灿，美丽，生命从此辉煌无悔!只要坚韧不拔的走下去!',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    MAvatar(
                      'https://img0.baidu.com/it/u=4117713405,2961605581&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=400',
                      radius: 0,
                      height: 52,
                      width: 52,
                    )
                  ],
                ),
              ),
              SizedBox(height: 8)
            ],
          );
        },
        separatorBuilder: (_, idnex) => Container(
              height: 8,
              color: MColors.backgroundColor,
            ),
        itemCount: 13);
  }
}
