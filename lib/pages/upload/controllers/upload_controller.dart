import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class PickItem {
  IconData? icon;
  String? label;
  ImageSource? pickType;
  PickItem({this.icon, this.label, this.pickType});
}

class UploadController extends GetxController {
  FijkPlayer playerView = FijkPlayer();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = VideoShowConfig();
  final videoPath = ''.obs;

  final List<PickItem> pickList = [
    PickItem(icon: Icons.photo, label: '相册 ', pickType: ImageSource.gallery),
    PickItem(icon: Icons.camera, label: '相机  ', pickType: ImageSource.camera)
  ];
  void sumbit() {
    print("tamade");
  }

  void videoPick(ImageSource? pickType) async {
    if (Get.isBottomSheetOpen == true) Get.close(0);

    final ImagePicker _picker = ImagePicker();
    final XFile? video =
        await _picker.pickVideo(source: pickType ?? ImageSource.gallery);

    if (video?.path != null) {
      videoPath.value = video!.path;
      player.setDataSource(video.path, showCover: true);
      playerView.setDataSource(video.path, autoPlay: true);
    }
  }

  void delVideo() {
    videoPath.value = '';
    player.reset();
    playerView.reset();
  }

  @override
  void onClose() {
    player.dispose();
    playerView.dispose();
    super.onClose();
  }
}
