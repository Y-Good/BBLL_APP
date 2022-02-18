import 'package:mvideo/widgets/public.dart';

///视频配置
class VideoShowConfig implements ShowConfigAbs {
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool liveMode = false;
}

///直播配置
class LiveShowConfig implements ShowConfigAbs {
  @override
  bool speedBtn = false;
  @override
  bool topBar = true;
  @override
  bool lockBtn = false;
  @override
  bool bottomPro = false;
  @override
  bool stateAuto = true;
  @override
  bool liveMode = true;
}

///发现页视频配置

class DiscoverShowConfig implements ShowConfigAbs {
  @override
  bool speedBtn = false;
  @override
  bool topBar = false;
  @override
  bool lockBtn = false;
  @override
  bool bottomPro = false;
  @override
  bool stateAuto = false;
  @override
  bool liveMode = false;
}
