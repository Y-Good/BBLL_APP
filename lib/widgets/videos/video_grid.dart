import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/videos/video_card.dart';

class VideoGrid extends StatelessWidget {
  final List<Video>? videoList;
  final ScrollPhysics? physics;
  final ValueChanged<int>? onLongPress;
  final bool shrinkWrap;
  const VideoGrid(
      {Key? key,
      this.videoList,
      this.physics,
      this.onLongPress,
      this.shrinkWrap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: videoList?.length ?? 0,
        itemBuilder: (_, index) {
          return VideoCard(
            video: videoList?[index],
            onLongPress: () =>
                onLongPress != null ? onLongPress!(videoList![index].id) : null,
            onTap: () => Get.toNamed(
              Routes.VIDEO_DETAIL,
              arguments: {'video': videoList?[index]},
            ),
          );
        });
  }
}
