import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/common/enums/video_mode_enum.dart';
import 'package:mvideo/widgets/videos/video_card.dart';

import '../controllers/live_controller.dart';

class LiveViewMy extends GetView<LiveController> {
  const LiveViewMy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (_, index) => VideoCard(
          isLive: index == 0 ? true : false,
          videoMode: VideoMode.live,
        ),
        itemCount: 4,
      ),
    ));
  }
}