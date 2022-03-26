import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class VideoWidthCard extends StatelessWidget {
  final Video? item;
  final bool isFormatTime;
  final EdgeInsetsGeometry? padding;
  const VideoWidthCard(
      {Key? key, this.item, this.padding, this.isFormatTime = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.VIDEO_DETAIL, arguments: {'video': item}),
      child: Padding(
        padding:
            padding ?? EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: MColors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            children: [
              SizedBox(width: 4),
              Expanded(
                flex: 4,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: MAvatar(
                      CommonUtils.handleSrcUrl(item?.cover ?? ''),
                      radius: 4,
                      height: 80,
                    )),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText(
                        item?.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        size: 15,
                      ),
                      SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MText(
                            item?.user?.nickname ?? '',
                            color: MColors.grey9,
                            size: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MIconText(
                                icon: IconFonts.iconLiulan,
                                iconSize: 14,
                                textSize: 12,
                                text: item?.view.toString() ?? '',
                              ),
                              MText(
                                isFormatTime && isNotNull(item?.time)
                                    ? CommonUtils.format(
                                            DateTime.parse(item?.time ?? '')) ??
                                        ''
                                    : CommonUtils.remindTime(item?.time) ?? '',
                                size: 12,
                                color: Colors.grey,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
