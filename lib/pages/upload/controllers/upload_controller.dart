import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class UploadController extends GetxController {
  FijkPlayer playerView = FijkPlayer();
  FijkPlayer player = FijkPlayer();
  ShowConfigAbs vSkinCfg = VideoShowConfig();
  final videoPath = ''.obs;

  void sumbit() {
    print("tamade");
  }

  void videoPick() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
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
