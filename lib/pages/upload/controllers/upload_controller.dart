import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/http/request/video/video_request.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:dio/dio.dart';

class UploadController extends GetxController {
  FijkPlayer playerView = FijkPlayer();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = VideoShowConfig();
  String? title;
  final videoPath = ''.obs;
  final coverPath = ''.obs;
  XFile? cover;
  XFile? video;

  void videoPick(ImageSource? pickType) async {
    if (Get.isBottomSheetOpen == true) Get.close(0);

    final ImagePicker _picker = ImagePicker();
    video = await _picker.pickVideo(source: pickType ?? ImageSource.gallery);

    if (video?.path != null) {
      videoPath.value = video!.path;
      player.setDataSource(video?.path ?? '', showCover: true);
    }
  }

  void coverPick(ImageSource? pickType) async {
    if (Get.isBottomSheetOpen == true) Get.close(0);

    final ImagePicker _picker = ImagePicker();
    cover = await _picker.pickImage(
        source: pickType ?? ImageSource.gallery, imageQuality: 70);

    if (cover?.path != null) {
      coverPath.value = cover!.path;
    }
  }

  void removeVideo() {
    videoPath.value = '';
    player.reset();
    playerView.reset();
  }

  void removeCover() {
    coverPath.value = '';
  }

  ///上传
  Future<void> onSumbit() async {
    print("00");
    if (cover != null && video != null && title != null) {
      FormData formdata = FormData.fromMap({
        "cover":
            await MultipartFile.fromFile(cover!.path, filename: cover!.name),
        'video':
            await MultipartFile.fromFile(video!.path, filename: video!.name),
        'title': title
      });
      bool? res = await VideoRequest.uploadVideo(formdata);
      CommonUtils.toast(res == true ? '上传成功' : '上传失败');
      if (res == true) Get.back();
    } else {
      CommonUtils.toast('还有东西没填');
    }
  }

  @override
  void onClose() {
    player.dispose();
    playerView.dispose();
    super.onClose();
  }
}
