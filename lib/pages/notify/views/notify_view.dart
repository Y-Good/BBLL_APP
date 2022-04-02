import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/common/enums/notify.enum.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/notify_controller.dart';

class NotifyView extends GetView<NotifyController> {
  @override
  Widget build(BuildContext context) {
    var items = controller.notifyList;
    return Scaffold(
        backgroundColor: MColors.background,
        appBar: MAppBar(
          title: "通知",
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (_, index) => Container(
                color: MColors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: MAvatar(
                        CommonUtils.handleSrcUrl(
                            items[index].fromUser?.avatar ?? ''),
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
                            MText(
                              items[index].fromUser?.nickname ?? '-',
                              color: MColors.grey6,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: items[index].type == NotifyType.thumbUp
                                  ? Icon(
                                      IconFonts.iconDianzan2,
                                      size: 18,
                                      color: MColors.primiaryColor,
                                    )
                                  : Text(
                                      items[index].comment?.content ?? '',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                            SizedBox(height: 4),
                            MText(
                              CommonUtils.remindTime(items[index].time ?? '') ??
                                  '-',
                              size: 12,
                              color: MColors.grey6,
                            )
                          ],
                        ),
                      ),
                    ),
                    isNull(items[index].video)
                        ? Container(
                            color: MColors.grey9.withOpacity(0.1),
                            width: 64,
                            height: 64,
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            alignment: Alignment.center,
                            child: MText(
                              items[index].comment?.content ?? '',
                              maxLines: 3,
                              size: 12,
                              color: Colors.grey[700],
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : MAvatar(
                            CommonUtils.handleSrcUrl(
                                items[index].video?.cover ?? ''),
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
          ),
        ));
  }
}
