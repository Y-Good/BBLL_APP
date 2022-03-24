import 'dart:io';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_ffmpeg/media_information.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/http/request/common_request.dart';
import 'package:mvideo/config/http/request/video_request.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/common/tag.dart';
import 'package:mvideo/pages/upload/views/tag_pick.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class UploadController extends GetxController {
  FijkPlayer playerView = FijkPlayer();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = VideoShowConfig();
  FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  FlutterFFprobe _flutterFFprobe = FlutterFFprobe();
  // FlutterFFmpegConfig _flutterFFmpegConfig = FlutterFFmpegConfig();
  final videoPath = ''.obs;
  final coverPath = ''.obs;
  final tagList = <Tag>[].obs;
  final tags = <int>[].obs;
  final checkTagList = <int>[].obs;
  final checkTagName = <String>[].obs;
  String? title;
  String? tagName;
  XFile? cover;
  XFile? video;

  @override
  Future<void> onInit() async {
    tagList.value = await CommonRequest.getTag() ?? [];
    super.onInit();
  }

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

  void pickTag() async {
    Get.bottomSheet(TagPickWidget());
  }

  ///上传
  Future<void> onSumbit() async {
    String? duration;
    String tempVideo = '/data/user/0/com.example.mvideo/cache/1.mp4';
    String tempCover = cover!.path.substring(0, cover?.path.lastIndexOf('/'));
    String? compressCoverPath;

    MediaInformation? fileInfo =
        await _flutterFFprobe.getMediaInformation(video!.path);
    duration = fileInfo.getMediaProperties()?['duration'];

    ///图片压缩
    CompressObject compressObject = CompressObject(
      imageFile: File(cover!.path),
      path: tempCover,
      quality: 85,
      step: 9,
    );
    Luban.compressImage(compressObject)
        .then((_path) => compressCoverPath = _path);

    ///视频压缩
    ///
    LoadingUtil.showLoading(msg: '压缩文件中');
    _flutterFFmpeg
        .execute("-i ${video!.path} -r 20 -b:v 1.5M $tempVideo")
        .then((info) async {
      if (info == 1) LoadingUtil.dismissLoading();
      if (cover != null && video != null && title != null) {
        FormData formdata = FormData.fromMap({
          'video':
              await MultipartFile.fromFile(tempVideo, filename: video!.name),
          "cover": await MultipartFile.fromFile(compressCoverPath!,
              filename: cover!.name),
          'title': title,
          'duration': double.parse(duration ?? '0').round().toString(),
          'tags': tags
        });
        bool? res = await VideoRequest.uploadVideo(formdata);
        CommonUtils.toast(res == true ? '上传成功' : '上传失败');
        if (res == true) Get.back();
      } else {
        CommonUtils.toast('还有东西没填');
      }
    });
  }

  //创建标签
  createTag() async {
    Tag tag = await CommonRequest.createTag(tagName ?? '');
    tagList.add(tag);
  }

  @override
  void onClose() {
    player.dispose();
    playerView.dispose();
    super.onClose();
  }
}
