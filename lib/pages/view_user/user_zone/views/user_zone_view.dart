import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
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
                    child: MAvatar(
                      CommonUtils.handleSrcUrl(
                        controller.user?.avatar ?? '',
                      ),
                      height: 82,
                      width: 82,
                    )),
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
                  onLongPress: (videoId) => controller.onMenu(videoId),
                  videoList: controller.videoList,
                ),
        ));
  }

  Widget userFollow() {
    return Container(
        padding: EdgeInsets.only(top: 8),
        child: Obx(
          () => ListView.separated(
            itemBuilder: (_, index) {
              User? followUser = controller.followList[index].follow;
              return MListTile(
                url: CommonUtils.handleSrcUrl(followUser?.avatar ?? ''),
                title: followUser?.nickname ?? '-',
                subtitle: isNotNull(followUser?.signature)
                    ? followUser?.signature
                    : '这个小可爱好懒',
                trailing: MButton(
                  label: '已关注',
                  width: 64,
                  height: 32,
                  bgColor: MColors.grey9.withOpacity(0.8),
                  onTap: () => controller.cancelFollow(followUser?.id),
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
    List<Comment> items = controller.commentList;
    return Obx(() => ListView.separated(
        itemBuilder: (_, index) {
          return Column(
            children: [
              MListTile(
                url: CommonUtils.handleSrcUrl(controller.user?.avatar ?? ''),
                title: controller.user?.nickname,
                subtitle: CommonUtils.remindTime(items[index].time),
                trailing: MIcon(
                  CupertinoIcons.delete,
                  size: 18,
                  onTap: () => controller.removeComment(items[index].id, index),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                alignment: Alignment.centerLeft,
                child: MText(
                  items[index].content ?? '-',
                  maxLines: 5,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                    color: MColors.background,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: InkWell(
                  onTap: () => items[index].level == 2
                      ? null
                      : Get.toNamed(Routes.VIDEO_DETAIL,
                          arguments: {'video': items[index].video}),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MText(
                            items[index].level == 2
                                ? '回复：${items[index].replyUser?.nickname}'
                                : items[index].video?.title ?? '-',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            color: items[index].level == 2
                                ? MColors.grey9
                                : MColors.black,
                          ),
                        ),
                      ),
                      MAvatar(
                        CommonUtils.handleSrcUrl(
                          items[index].video?.cover ?? '',
                        ),
                        radius: 8,
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
        itemCount: items.length));
  }
}
