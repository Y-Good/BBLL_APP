import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/models/common/histroy.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_history_controller.dart';

class UserHistoryView extends GetView<UserHistoryController> {
  const UserHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList<Histroy>? items = controller.histroyList;
    return Scaffold(
        appBar: MAppBar(title: '历史记录'),
        body: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(Routes.VIDEO_DETAIL,
                    arguments: {'video': items[index].video}),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: index == 19 ? 8 : 0),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: MColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: MAvatar(
                                CommonUtils.handleSrcUrl(
                                    items[index].video?.cover ?? ''),
                                radius: 4,
                                height: 80,
                              )

                              // ClipRRect(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(4)),
                              //   child: Image.network(
                              //     CommonUtils.handleSrcUrl(
                              //         items[index].video?.cover ?? ''),
                              //     height: 80,
                              //     fit: BoxFit.cover,
                              //     errorBuilder: (context, Object exception,
                              //         StackTrace? stackTrace) {
                              //       return Image.asset(
                              //           'assets/avatar/default.jpg');
                              //     },
                              //   ),
                              // ),
                              ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MText(
                                  items[index].video?.title ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  size: 15,
                                ),
                                SizedBox(height: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MText(
                                      items[index].video?.user?.nickname ?? '',
                                      color: MColors.grey9,
                                      size: 12,
                                    ),
                                    // MText(
                                    //   "2020-12-32",
                                    //   color: MColors.grey9,
                                    //   size: 10,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MIconText(
                                          icon: IconFonts.iconLiulan,
                                          iconSize: 14,
                                          textSize: 12,
                                          text: items[index]
                                                  .video
                                                  ?.view
                                                  .toString() ??
                                              '',
                                        ),
                                        MText(
                                          CommonUtils.remindTime(
                                                  items[index].time) ??
                                              '',
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
            },
            itemCount: items.length,
          ),
        ));
  }
}
