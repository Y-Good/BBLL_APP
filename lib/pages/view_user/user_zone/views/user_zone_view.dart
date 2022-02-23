import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/text/m_double_text.dart';

import '../controllers/user_zone_controller.dart';

class UserZoneView extends GetView<UserZoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MAppBar(
            actionWidget: MIcon(IconFonts.iconSousuo, color: Colors.black)),
        body: Container(
            width: double.infinity,
            color: MColors.white,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MDoubleText(
                          label: '获赞', value: '1233万', lableColor: Colors.grey),
                      SizedBox(width: 48),
                      MDoubleText(
                          label: '粉丝', value: '13万', lableColor: Colors.grey)
                    ],
                  ),
                ),
                Flexible(
                  child: MTabPageView(
                      initialIndex: controller.initialIndex,
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
          color: MColors.background,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: controller.videoList.length == 0
              ? Center(child: MText('没得视频'))
              : VideoGrid(
                  // ignore: invalid_use_of_protected_member
                  videoList: controller.videoList.value,
                ),
        ));
  }

  Widget userFollow() {
    return Container(
        padding: EdgeInsets.only(top: 8),
        child: Obx(
          () => ListView.separated(
            itemBuilder: (_, index) {
              User? followUser = controller.followList[index];
              return MListTile(
                url:
                    'https://img2.baidu.com/it/u=1052567076,3275246168&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
                title: followUser.nickname ?? '-',
                subtitle: isNotNull(followUser.signature)
                    ? followUser.signature
                    : '这个小可爱好懒',
                trailing: MButton(
                  label: '已关注',
                  width: 64,
                  height: 32,
                  bgColor: MColors.grey9,
                  onTap: () => controller.cancelFollow(followUser.id),
                ),
              );
            },
            itemCount: controller.followList.length,
            separatorBuilder: (_, index) => Divider(
              height: .5,
              color: Colors.grey[300],
            ),
          ),
        ));
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
                    color: MColors.background,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.VIDEO_DETAIL),
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
              ),
              SizedBox(height: 8)
            ],
          );
        },
        separatorBuilder: (_, idnex) => Container(
              height: 8,
              color: MColors.background,
            ),
        itemCount: 13);
  }
}
