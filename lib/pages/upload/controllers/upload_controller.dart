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
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadController extends GetxController {
  FijkPlayer playerView = FijkPlayer();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = VideoShowConfig();
  FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  FlutterFFprobe _flutterFFprobe = FlutterFFprobe();
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
  Directory? tempDirVideo;
  Directory? tempDirCover;

  ///时长
  String? duration;

  ///大小
  String? size;

  ///视频临时缓存
  String? tempVideo;

  ///图片临时缓存
  String? tempCover;

  @override
  Future<void> onInit() async {
    tempDirVideo = await getTemporaryDirectory();
    tempDirCover = await getTemporaryDirectory();
    tempVideo = "${tempDirVideo?.path}/temp.mp4";
    tempCover = tempDirCover?.path;
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
    LoadingUtil.showLoading(msg: '上传中');
    handleFile();
    if (video != null && title != null) {
      FormData formdata = FormData.fromMap({
        'video':
            await MultipartFile.fromFile(tempVideo!, filename: video!.name),
        "cover": await MultipartFile.fromFile(coverPath.value,
            filename: coverPath.value.split('/').last),
        'title': title,
        'duration': duration ?? '0',
        'tags': tags
      });

      bool? res = await VideoRequest.uploadVideo(formdata);
      LoadingUtil.dismissLoading();
      CommonUtils.toast(res == true ? '上传成功' : '上传失败');
      if (res == true) Get.back();
    } else {
      CommonUtils.toast('还有东西没填');
    }
  }

  //创建标签
  void createTag() async {
    Tag tag = await CommonRequest.createTag(tagName ?? '');
    tagList.add(tag);
  }

  Future<void> handleFile() async {
    //获取视频略缩图
    if (isNull(cover)) {
      coverPath.value = (await VideoThumbnail.thumbnailFile(
        video: video!.path,
        thumbnailPath: tempCover,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      ))!;
    } else {
      //有图就压缩
      CompressObject compressObject = CompressObject(
        imageFile: File(cover!.path),
        path: tempCover,
        quality: 85,
        step: 9,
      );
      Luban.compressImage(compressObject)
          .then((_path) => coverPath.value = _path!);
    }

    //获取视频文件信息
    MediaInformation? videoInfo =
        await _flutterFFprobe.getMediaInformation(video!.path);
    duration = videoInfo.getMediaProperties()?['duration'];
    size = videoInfo.getMediaProperties()?['size'];
    if (isNotNull(size) && (int.parse(size!) / 1000000).toDouble() > 20) {
      LoadingUtil.showLoading(msg: '压缩文件中');
      _flutterFFmpeg
          .execute("-i ${video!.path} -r 20 -b:v 1.5M $tempVideo")
          .then((info) async {
        if (info == 1) LoadingUtil.dismissLoading();
      });
    } else {
      tempVideo = videoPath.value;
    }
  }

  @override
  void onClose() {
    player.dispose();
    playerView.dispose();
    super.onClose();
  }
}
