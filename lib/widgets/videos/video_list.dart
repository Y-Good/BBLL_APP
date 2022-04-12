import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class VideoList extends StatelessWidget {
  final List<Video>? videoList;
  final bool isShowTip;
  VideoList({Key? key, this.videoList, this.isShowTip = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isShowTip
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Center(
                    child: MText(
                      '展示近七天数据',
                      size: 10,
                      color: MColors.grey6,
                    ),
                  ),
                )
              : Container(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.VIDEO_DETAIL,
                  arguments: {'video': videoList?[index]},
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: isShowTip ? 4 : 8,
                      bottom: index == 19 ? 8 : 0),
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        color: MColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: Image(
                            image: NetworkImage(
                              CommonUtils.handleSrcUrl(
                                videoList?[index].cover ?? '',
                              ),
                            ),
                            height: 80,
                            fit: BoxFit.cover,
                            width: 80 * 16 / 9,
                            errorBuilder: (context, Object exception,
                                StackTrace? stackTrace) {
                              return Container(
                                  width: 80 * 16 / 9,
                                  height: 80,
                                  color: MColors.white,
                                  child: SvgPicture.asset(Msvg.img));
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MText(
                                  videoList?[index].title ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                // SizedBox(height: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MText(
                                      videoList?[index].user?.nickname ?? '-',
                                      color: MColors.grey9,
                                      size: 10,
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        MIconText(
                                          icon: IconFonts.iconLiulan,
                                          iconSize: 14,
                                          textSize: 12,
                                          text: transformView(int.parse(
                                              videoList?[index].view ?? '0')),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: MIconText(
                                            icon: IconFonts.iconDianzan2,
                                            iconSize: 12,
                                            textSize: 12,
                                            text: transformView(int.parse(
                                                videoList?[index].thumbUp ??
                                                    '0')),
                                          ),
                                        ),
                                        MText(
                                          CommonUtils.remindTime(
                                                  videoList?[index].time) ??
                                              '-',
                                          color: MColors.grey9,
                                          size: 12,
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
            },
            itemCount: videoList?.length ?? 0,
          ),
        ],
      ),
    );
  }
}
