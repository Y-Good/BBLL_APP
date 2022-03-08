import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/stream_information.dart';
import 'package:get/get.dart';
import 'package:mvideo/utils/utils.dart';

class VideoUtils {
  ///处理时间
  static String duration2String(int? duration) {
    if (duration == null) return '00:00';
    Duration _duration = new Duration(seconds: duration);
    if (_duration.inMilliseconds < 0) return "-: negtive";

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(_duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_duration.inSeconds.remainder(60));
    int inHours = _duration.inHours;
    return inHours > 0
        ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
        : "$twoDigitMinutes:$twoDigitSeconds";
  }

  ///获取分辨率
  static double getVideoHeight(String path) {
    if (isNotNull(path)) {
      FlutterFFprobe _flutterFFprobe = FlutterFFprobe();
      _flutterFFprobe.getMediaInformation(path).then((info) {
        if (info.getStreams() != null) {
          List<StreamInformation>? streams = info.getStreams();
          return (streams?.first.getAllProperties()['height'] as int)
              .toDouble();
        }
      });
    }
    return Get.size.width * 9 / 16;
  }
}
