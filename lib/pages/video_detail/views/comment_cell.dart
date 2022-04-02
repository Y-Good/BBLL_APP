import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/video_detail/controllers/video_detail_controller.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/public.dart';

class CommentCell extends StatelessWidget {
  final Comment? item;
  final int? index;
  final controller = Get.find<VideoDetailController>();
  CommentCell({Key? key, this.item, this.index}) : super(key: key);

  void replayComment() {
    Get.bottomSheet(
        Container(
            height: Get.height / 1.56,
            padding: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: MColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Obx(() => ListView.builder(
                      padding: EdgeInsets.only(top: 28),
                      itemBuilder: (context, index) {
                        return CommentCell(
                          item: controller.secondCommentList[index],
                          index: index,
                        );
                      },
                      itemCount: controller.secondCommentList.length,
                    )),
                Positioned(
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: MText(
                      '评论回复',
                      size: 18,
                    ),
                  ),
                )
              ],
            )),
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MAvatar(
            CommonUtils.handleSrcUrl(item?.user?.avatar ?? ''),
          ),
          SizedBox(width: 8),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MText(
                    item?.user?.nickname ?? '-',
                    size: 13,
                    color: Colors.grey,
                  ),
                  Offstage(
                    offstage: item?.user?.id != controller.video?.user?.id,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: .5,
                            color: MColors.primiaryColor,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: MText(
                          '作者',
                          size: 10,
                          color: MColors.primiaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MText(
                  item?.content ?? '',
                  maxLines: 8,
                  onTap: () {
                    controller.level = 2;
                    controller.parentId = item?.id;
                    controller.replyIndex = index;
                    controller.placeholder.value = '回复：${item?.content}';
                    // FocusNode().requestFocus();
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    CommonUtils.remindTime(item?.time) ?? '时间错误',
                    size: 12,
                    color: Colors.grey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MIconText(
                        iconSize: 17,
                        icon: item?.isThumbUp ?? false
                            ? IconFonts.iconDianzan2
                            : IconFonts.iconDianzan1,
                        color: item?.isThumbUp ?? false
                            ? MColors.primiaryColor
                            : null,
                        text: item?.thumbUpCount.toString(),
                        onTap: () => controller.onThumbUpComment(
                          item?.id,
                          index!,
                          item?.level,
                        ),
                      ),
                      Offstage(
                        offstage: item?.level == 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: MIconText(
                            icon: IconFonts.iconPinglun,
                            text: item?.replyCount.toString(),
                            iconSize: 19,
                            onTap: () {
                              if (item?.replyCount == 0) return;
                              controller.getSecondComment(item?.id);
                              controller.parentId = item?.id;
                              replayComment();
                            },
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: controller.isUser
                            ? !controller.isUser
                            : !(item?.user?.id == controller.user?.id),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: MText(
                            '删除',
                            size: 12,
                            color: MColors.grey9,
                            onTap: () =>
                                controller.removeComment(item?.id, index ?? 0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
