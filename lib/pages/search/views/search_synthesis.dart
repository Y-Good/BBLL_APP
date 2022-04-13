import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/search/controllers/search_controller.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/videos/video_width_card.dart';

class SearchSynthesisPage extends StatelessWidget {
  final User? user;
  final List<Video>? videoList;
  final SearchController userZoneCtl = Get.find<SearchController>();
  SearchSynthesisPage({Key? key, this.user, this.videoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isNotNull(user) && isNotNull(videoList)
        ? SingleChildScrollView(
            child: Column(
              children: [
                ...isNotNull(user?.id)
                    ? [
                        Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, right: 10, top: 8),
                          color: Colors.white,
                          child: MListTile(
                            url: CommonUtils.handleSrcUrl(user?.avatar ?? ''),
                            title: user?.nickname ?? '-',
                            subtitle: isNotNull(user?.signature)
                                ? (user?.signature)
                                : '这个小可爱好懒',
                            trailing: MButton(
                              label: '已关注',
                              width: 64,
                              height: 32,
                              bgColor: MColors.grey9.withOpacity(0.8),
                              onTap: () => userZoneCtl.cancelFollow(user?.id),
                            ),
                          ),
                        ),
                      ]
                    : [],
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => VideoWidthCard(
                          isFormatTime: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          item: videoList?[index],
                        ),
                    itemCount: videoList?.length),
              ],
            ),
          )
        : MEmpty(
            text: '暂无搜索结果',
            type: Msvg.search,
          );
  }
}
