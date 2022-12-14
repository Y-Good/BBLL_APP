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
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
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
  final homeCtl = Get.find<HomeController>();
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
      //获取视频略缩图
      if (isNull(cover)) {
        coverPath.value = (await VideoThumbnail.thumbnailFile(
          video: video!.path,
          thumbnailPath: tempCover,
          imageFormat: ImageFormat.JPEG,
          quality: 75,
        ))!;
      }
    }
  }

  void coverPick(ImageSource? pickType) async {
    if (Get.isBottomSheetOpen == true) Get.close(0);

    final ImagePicker _picker = ImagePicker();
    cover = await _picker.pickImage(
        source: pickType ?? ImageSource.gallery, imageQuality: 70);

    if (cover?.path != null) {
      CompressObject compressObject = CompressObject(
        imageFile: File(cover!.path),
        path: tempCover,
        quality: 85,
        step: 9,
      );
      Luban.compressImage(compressObject)
          .then((_path) => coverPath.value = _path!);
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
    LoadingUtil.showLoading(msg: '上传中', dismissOnTap: true);

    if (video != null && title != null && isNotNull(coverPath.value.trim())) {
      await handleFile();
      FormData formdata = FormData.fromMap({
        'video':
            await MultipartFile.fromFile(tempVideo!, filename: video!.name),
        "cover": await MultipartFile.fromFile(coverPath.value,
            filename: coverPath.value.split('/').last),
        'title': title,
        'duration': duration?.split('.').first ?? '0',
        'tags': tags
      });
      Video? res = await VideoRequest.uploadVideo(formdata);
      LoadingUtil.dismissLoading();
      // CommonUtils.toast(res == true ? '上传成功' : '上传失败');
      if (res?.id != null) {
        homeCtl.videoList.insert(0, res!);
        delFile();
        Get.back();
      }
    } else {
      LoadingUtil.dismissLoading();
      CommonUtils.toast('请填写完整内容');
    }
  }

  //创建标签
  void createTag() async {
    Tag tag = await CommonRequest.createTag(tagName ?? '');
    tagList.add(tag);
  }

  Future<void> handleFile() async {
    //获取视频文件信息
    MediaInformation? videoInfo =
        await _flutterFFprobe.getMediaInformation(video!.path);
    duration = videoInfo.getMediaProperties()?['duration'];
    size = videoInfo.getMediaProperties()?['size'];
    if (isNotNull(size) && (int.parse(size!) ~/ 1000000).toDouble() > 3) {
      LoadingUtil.showLoading(msg: '压缩文件中');
      // String command = "-i ${video!.path} -r 20 -b:v 1M -s 1280x720 $tempVideo";
      String commands =
          "-i ${video!.path} -c:v libx264 -preset veryfast -r 25 -b:v 1M -s 1280x720 -c:a copy -y -hide_banner  $tempVideo";
      var info = await _flutterFFmpeg.execute(commands);
      // tempDirCover = await getTemporaryDirectory();
      // tempVideo = "${tempDirVideo?.path}/temp.mp4";
      if (info == 0) LoadingUtil.dismissLoading();
      if (info == 1) {
        LoadingUtil.dismissLoading();
        CommonUtils.toast('压缩失败');
      }
    } else {
      tempVideo = videoPath.value;
    }
  }

  Future<void> delFile() async {
    var file = File(tempVideo!);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  void onClose() {
    player.dispose();
    playerView.dispose();
    delFile();
    LoadingUtil.dismissLoading();
    super.onClose();
  }
}
