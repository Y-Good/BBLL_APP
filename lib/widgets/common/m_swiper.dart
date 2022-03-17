import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/common/m_avatar.dart';

class MSwiper extends StatelessWidget {
  final List<Video>? bannerList;
  const MSwiper({Key? key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16 / 7,
          child: Swiper(
            autoplay: true,
            pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: DotSwiperPaginationBuilder(
                  activeColor: MColors.primiaryColor),
            ),
            onTap: (index) => Get.toNamed(
              Routes.VIDEO_DETAIL,
              arguments: {'video': bannerList?[index]},
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: MColors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MAvatar(
                  CommonUtils.handleSrcUrl(bannerList?[index].cover ?? ''),
                  radius: 0,
                ),
              );
            },
            itemCount: bannerList?.length ?? 0,
          ),
        ));
  }
}
