import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/models/common/histroy.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/videos/video_width_card.dart';
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
              ///替换时间，懒得整
              items[index].video?.time = items[index].time;
              return VideoWidthCard(item: items[index].video);
            },
            itemCount: items.length,
          ),
        ));
  }
}
