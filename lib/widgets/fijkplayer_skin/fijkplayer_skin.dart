import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/pages/video_detail/controllers/video_detail_controller.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/widgets/fijkplayer_skin/slider.dart'
    show NewFijkSliderColors, NewFijkSlider;
import 'package:mvideo/widgets/public.dart';
import 'package:wakelock/wakelock.dart';

double speed = 1.0;
bool lockStuff = false;
bool hideLockStuff = false;
const double barHeight = 50.0;
final double barFillingHeight =
    MediaQueryData.fromWindow(window).padding.top + barHeight;
final double barGap = barFillingHeight - barHeight;
final playTitle = ''.obs;

abstract class ShowConfigAbs {
  late bool speedBtn;
  late bool lockBtn;
  late bool topBar;
  late bool bottomPro;
  late bool stateAuto;
  late bool liveMode;
  late bool completeTop;
}

String _duration2String(Duration duration) {
  if (duration.inMilliseconds < 0) return "-: negtive";

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  int inHours = duration.inHours;
  return inHours > 0
      ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final Size viewSize;
  final Rect texturePos;
  final BuildContext? pageContent;
  final String playerTitle;
  final ShowConfigAbs showConfig;
  final String curPlayUrl;

  const CustomFijkPanel({
    required this.player,
    required this.viewSize,
    required this.texturePos,
    this.pageContent,
    this.playerTitle = "",
    required this.showConfig,
    required this.curPlayUrl,
  });

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  FijkPlayer get player => widget.player;
  ShowConfigAbs get showConfig => widget.showConfig;
  String get curPlayUrl => widget.curPlayUrl;

  bool _lockStuff = lockStuff;
  bool _hideLockStuff = hideLockStuff;
  Timer? _hideLockTimer;

  bool _isPlaying = false;

  FijkState? _playerState;

  StreamSubscription? _currentPosSubs;

  void initEvent() {
    // init plater state
    setState(() {
      _playerState = player.value.state;
    });
    if (player.value.duration.inMilliseconds > 0 && !_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    }
    player.addListener(_playerValueChanged);
    Wakelock.enable();
  }

  @override
  void initState() {
    super.initState();
    playTitle.value = widget.playerTitle;
    initEvent();
  }

  @override
  void dispose() {
    _currentPosSubs?.cancel();
    _hideLockTimer?.cancel();
    player.removeListener(_playerValueChanged);
    Wakelock.disable();
    super.dispose();
  }

  // ?????????????????????
  void _playerValueChanged() {
    if (player.value.duration.inMilliseconds > 0 && !_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    }
    setState(() {
      _playerState = player.value.state;
    });
  }

  // ??????UI lock????????????
  void changeLockState(bool state) {
    setState(() {
      _lockStuff = state;
      if (state == true) {
        _hideLockStuff = true;
        _cancelAndRestartLockTimer();
      }
    });
  }

  void _cancelAndRestartLockTimer() {
    if (_hideLockStuff == true) {
      _startHideLockTimer();
    }
    setState(() {
      _hideLockStuff = !_hideLockStuff;
    });
  }

  void _startHideLockTimer() {
    _hideLockTimer?.cancel();
    _hideLockTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _hideLockStuff = true;
      });
    });
  }

  // ????????????
  Widget _buildLoadingWidget() {
    return Stack(
      children: [
        showConfig.topBar
            ? Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Container(
                  // height:
                  //     showConfig.stateAuto && !widget.player.value.fullScreen
                  //         ? barFillingHeight
                  //         : barHeight,
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: barHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _buildTopBackBtn(),
                        Expanded(
                          child: Text(
                            widget.playerTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Center(
            child: const SizedBox(
              width: barHeight * 0.8,
              height: barHeight * 0.8,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ??? ??????
  Widget _buidLockStateDetctor() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _cancelAndRestartLockTimer,
      child: AnimatedOpacity(
        opacity: _hideLockStuff ? 0.0 : 0.7,
        duration: const Duration(milliseconds: 400),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              top:
                  showConfig.stateAuto && !player.value.fullScreen ? barGap : 0,
            ),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                setState(() {
                  _lockStuff = false;
                  _hideLockStuff = true;
                });
              },
              icon: const Icon(Icons.lock_open),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // ????????????
  Widget _buildTopBackBtn() {
    return Container(
      height: barHeight,
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(IconFonts.iconFanhui),
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: Colors.white,
        onPressed: () {
          // ????????????????????????????????????????????????
          if (widget.player.value.fullScreen) {
            player.exitFullScreen();
          } else {
            if (widget.pageContent == null) return;
            player.stop();
            Navigator.pop(widget.pageContent!);
          }
        },
      ),
    );
  }

  // ????????????
  Widget _buildErrorContext() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ????????????
          const Icon(
            Icons.error,
            size: 48,
            color: Colors.white,
          ),
          // ????????????
          SizedBox(height: 8),
          const Text(
            "???????????????????????????????????????",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // ??????
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () async {
              // ????????????
              await player.reset();
              await player.setDataSource(curPlayUrl, autoPlay: true);
            },
            child: const Text(
              "????????????",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // ??????????????????
  Widget _buildErrorWidget() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          showConfig.topBar
              ? Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: barHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _buildTopBackBtn(),
                          Expanded(
                            child: Text(
                              playTitle.value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: _buildErrorContext(),
          )
        ],
      ),
    );
  }

//????????????
  Widget _buildRestartWidget() {
    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black54,
            )),
        Center(
          //???????????????
          child: MButton(
            width: 100,
            radius: 20,
            onTap: () async {
              await player.start();
            },
            border: Border.all(width: 1, color: Colors.white70),
            bgColor: Colors.transparent,
            child: MIconText(
              icon: Icons.refresh,
              color: Colors.white,
              text: "????????????",
            ),
          ),
        ),
        showConfig.completeTop ? _buildTopBackBtn() : SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Rect rect = Rect.fromLTWH(
      0,
      0,
      widget.viewSize.width,
      widget.viewSize.height,
    );
    List<Widget> ws = [];

    if (_playerState == FijkState.error) {
      ws.add(
        _buildErrorWidget(),
      );
    } else if (_playerState == FijkState.asyncPreparing && !_isPlaying) {
      ws.add(
        _buildLoadingWidget(),
      );
    } else if (_playerState == FijkState.completed) {
      ws.add(
        _buildRestartWidget(),
      );
    } else {
      if (_lockStuff == true &&
          showConfig.lockBtn &&
          widget.player.value.fullScreen) {
        ws.add(
          _buidLockStateDetctor(),
        );
      } else {
        ws.add(
          _buildGestureDetector(
            player: widget.player,
            texturePos: widget.texturePos,
            showConfig: widget.showConfig,
            pageContent: widget.pageContent,
            playerTitle: widget.playerTitle,
            viewSize: widget.viewSize,
            changeLockState: changeLockState,
          ),
        );
      }
    }

    return WillPopScope(
      child: Positioned.fromRect(
        rect: rect,
        child: Stack(
          children: ws,
        ),
      ),
      onWillPop: () async {
        if (!widget.player.value.fullScreen) widget.player.stop();
        return true;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ignore: camel_case_types
class _buildGestureDetector extends StatefulWidget {
  final FijkPlayer player;
  final Size viewSize;
  final Rect texturePos;
  final BuildContext? pageContent;
  final String playerTitle;
  final Function changeLockState;
  final ShowConfigAbs showConfig;
  // ????????????????????????????????????
  final _hideStuff = true;
  const _buildGestureDetector({
    Key? key,
    required this.player,
    required this.viewSize,
    required this.texturePos,
    this.pageContent,
    this.playerTitle = "",
    required this.showConfig,
    required this.changeLockState,
  }) : super(key: key);

  @override
  _buildGestureDetectorState createState() =>
      _buildGestureDetectorState(_hideStuff);
}

// ignore: camel_case_types
class _buildGestureDetectorState extends State<_buildGestureDetector> {
  FijkPlayer get player => widget.player;
  ShowConfigAbs get showConfig => widget.showConfig;

  Duration _duration = const Duration();
  Duration _currentPos = const Duration();
  Duration _bufferPos = const Duration();

  // ????????????
  Duration _dargPos = const Duration();

  bool _isTouch = false;

  bool _playing = false;
  bool _prepared = false;
  bool _completed = false;
  String? _exception;

  double? updatePrevDx;
  double? updatePrevDy;
  int? updatePosX;

  bool? isDargVerLeft;

  double? updateDargVarVal;

  bool varTouchInitSuc = false;

  bool _buffering = false;

  double _seekPos = -1.0;

  StreamSubscription? _currentPosSubs;
  StreamSubscription? _bufferPosSubs;
  StreamSubscription? _bufferingSubs;

  Timer? _hideTimer;

  bool _hideStuff = true;

  bool _hideSpeedStu = true;
  double _speed = speed;

  bool _isHorizontalMove = false;

  bool _isSpeed = false;

  Map<String, double> speedList = {
    "2.0": 2.0,
    "1.8": 1.8,
    "1.5": 1.5,
    "1.2": 1.2,
    "1.0": 1.0,
  };

  // ?????????????????????
  _buildGestureDetectorState(this._hideStuff);

  void initEvent() {
    // ?????????????????????????????????????????????????????????
    setState(() {
      _speed = speed;
    });
    // ????????????
    _startHideTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _hideTimer?.cancel();

    player.removeListener(_playerValueChanged);
    _currentPosSubs?.cancel();
    _bufferPosSubs?.cancel();
    _bufferingSubs?.cancel();
  }

  @override
  void initState() {
    super.initState();

    initEvent();

    _duration = player.value.duration;
    _currentPos = player.currentPos;
    _bufferPos = player.bufferPos;
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;
    _exception = player.value.exception.message;
    _buffering = player.isBuffering;
    _completed = player.state == FijkState.completed;

    player.addListener(_playerValueChanged);

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
      });
    });

    _bufferPosSubs = player.onBufferPosUpdate.listen((v) {
      setState(() {
        _bufferPos = v;
      });
    });

    _bufferingSubs = player.onBufferStateUpdate.listen((v) {
      setState(() {
        _buffering = v;
      });
    });
  }

  void _playerValueChanged() async {
    // await player.stop();
    FijkValue value = player.value;
    if (value.duration != _duration) {
      setState(() {
        _duration = value.duration;
      });
    }
    // print(
    //     '+++++ $value.state  ???????????????  ${value.state == FijkState.started} +++++');
    bool playing = (value.state == FijkState.started);
    bool prepared = value.prepared;
    bool completed = value.state == FijkState.completed;
    String? exception = value.exception.message;
    // ????????????????????????
    if (playing != _playing ||
        prepared != _prepared ||
        exception != _exception ||
        completed != _completed) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
        _exception = exception;
        _completed = completed;
      });
    }
  }

  _onHorizontalDragStart(detills) {
    if (showConfig.liveMode) return;
    setState(() {
      updatePrevDx = detills.globalPosition.dx;
      updatePosX = _currentPos.inMilliseconds;
    });
  }

  _onHorizontalDragUpdate(detills) {
    if (showConfig.liveMode) return;
    double curDragDx = detills.globalPosition.dx;
    // ?????????????????????????????????
    int cdx = curDragDx.toInt();
    int pdx = updatePrevDx!.toInt();
    bool isBefore = cdx > pdx;

    // ???????????????????????????
    int newInterval = pdx - cdx;
    double playerW = MediaQuery.of(context).size.width;
    int curIntervalAbs = newInterval.abs();
    double movePropCheck = (curIntervalAbs / playerW) * 100;

    // ????????????????????????
    double durProgCheck = _duration.inMilliseconds.toDouble() / 100;
    int checkTransfrom = (movePropCheck * durProgCheck).toInt();
    int dragRange =
        isBefore ? updatePosX! + checkTransfrom : updatePosX! - checkTransfrom;

    // ???????????? ??????
    int lastSecond = _duration.inMilliseconds;
    if (dragRange >= _duration.inMilliseconds) {
      dragRange = lastSecond;
    }
    // ???????????? ??????
    if (dragRange <= 0) {
      dragRange = 0;
    }

    setState(() {
      _isHorizontalMove = true;
      _hideStuff = false;
      _isTouch = true;
      // ????????????????????????????????????
      updatePrevDx = curDragDx;
      // ????????????
      updatePosX = dragRange.toInt();
      _dargPos = Duration(milliseconds: updatePosX!.toInt());
    });
  }

  _onHorizontalDragEnd(detills) {
    if (showConfig.liveMode) return;
    player.seekTo(_dargPos.inMilliseconds);
    setState(() {
      _isHorizontalMove = false;
      _isTouch = false;
      _hideStuff = true;
      _currentPos = _dargPos;
    });
  }

  _onVerticalDragStart(detills) async {
    double clientW = widget.viewSize.width;
    double curTouchPosX = detills.globalPosition.dx;

    setState(() {
      // ????????????
      updatePrevDy = detills.globalPosition.dy;
      // ????????????
      isDargVerLeft = (curTouchPosX > (clientW / 2)) ? false : true;
    });
    // ?????? ?????? ?????? ??? ?????? ?????? ??????
    if (!isDargVerLeft!) {
      // ??????
      await FijkVolume.getVol().then((double v) {
        varTouchInitSuc = true;
        setState(() {
          updateDargVarVal = v;
        });
      });
    } else {
      // ??????
      await FijkPlugin.screenBrightness().then((double v) {
        varTouchInitSuc = true;
        setState(() {
          updateDargVarVal = v;
        });
      });
    }
  }

  _onVerticalDragUpdate(detills) {
    if (!varTouchInitSuc) return null;
    double curDragDy = detills.globalPosition.dy;
    // ?????????????????????????????????
    int cdy = curDragDy.toInt();
    int pdy = updatePrevDy!.toInt();
    bool isBefore = cdy < pdy;
    // + -, ?????????, ??????????????????????????????> 3
    if (isBefore && pdy - cdy < 3 || !isBefore && cdy - pdy < 3) return null;
    // ??????
    double dragRange =
        isBefore ? updateDargVarVal! + 0.03 : updateDargVarVal! - 0.03;
    // ????????????
    if (dragRange > 1) {
      dragRange = 1.0;
    }
    if (dragRange < 0) {
      dragRange = 0.0;
    }
    setState(() {
      updatePrevDy = curDragDy;
      varTouchInitSuc = true;
      updateDargVarVal = dragRange;
      // ??????
      if (!isDargVerLeft!) {
        FijkVolume.setVol(dragRange);
      } else {
        FijkPlugin.setScreenBrightness(dragRange);
      }
    });
  }

  _onVerticalDragEnd(detills) {
    setState(() {
      varTouchInitSuc = false;
    });
  }

  void _playOrPause() {
    if (_playing == true) {
      player.pause();
    } else {
      player.start();
    }
  }

  void _cancelAndRestartTimer() {
    if (_hideStuff == true) {
      _startHideTimer();
    }

    setState(() {
      _hideStuff = !_hideStuff;
      if (_hideStuff == true) {
        _hideSpeedStu = true;
      }
    });
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _hideStuff = true;
        _hideSpeedStu = true;
      });
    });
  }

  void _showVideos() async {
    VideoDetailController vdCtl = Get.put(VideoDetailController());
    List<Video> videoList = await vdCtl.getUserVideos();
    int? videoId = vdCtl.video?.id;
    Get.bottomSheet(
        Container(
          height: 160,
          alignment: Alignment.center,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (videoId == videoList[index].id) return;
                  playTitle.value = videoList[index].title ?? '';
                  await player.reset();
                  await player.setDataSource(
                      CommonUtils.handleSrcUrl(videoList[index].url ?? ''),
                      autoPlay: true);
                  Get.back();
                },
                child: Container(
                  width: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Colors.black,
                          boxShadow: videoId == videoList[index].id
                              ? [
                                  BoxShadow(
                                    color: MColors.primiaryColor,
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: MColors.white,
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  )
                                ]
                              : [],
                        ),
                        child: Image.network(
                          CommonUtils.handleSrcUrl(
                              videoList[index].cover ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        videoList[index].title ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ),
            ),
            itemCount: videoList.length,
          ),
        ),
        // barrierColor: Colors.transparent,
        backgroundColor: Colors.black.withOpacity(0.5));
  }
//????????????

  // ??????????????? - ????????????
  // Widget _buildPlayStateBtn() {
  //   IconData iconData =
  //       _playing ? IconFonts.iconBofangqiZanting : IconFonts.iconBofangqiBofang;

  //   return IconButton(
  //     icon: Icon(iconData),
  //     color: Colors.white,
  //     padding: const EdgeInsets.only(
  //       left: 16.0,
  //       right: 16.0,
  //     ),
  //     splashColor: Colors.transparent,
  //     highlightColor: Colors.transparent,
  //     onPressed: _playOrPause,
  //   );
  // }

  // ?????????ui ??????
  Widget _buildBottomBar(BuildContext context) {
    // ??????????????????
    double duration = _duration.inMilliseconds.toDouble();
    double currentValue = _seekPos > 0
        ? _seekPos
        : (_isHorizontalMove
            ? _dargPos.inMilliseconds.toDouble()
            : _currentPos.inMilliseconds.toDouble());
    currentValue = min(currentValue, duration);
    currentValue = max(currentValue, 0);

    // ????????????????????????
    double curConWidth = MediaQuery.of(context).size.width;
    double curTimePro = (currentValue / duration) * 100;
    double curBottomProW = (curConWidth / 100) * curTimePro;

    return SizedBox(
      height: barHeight,
      child: Stack(
        children: [
          // ??????UI?????????
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedOpacity(
              opacity: _hideStuff ? 0.0 : 0.8,
              duration: const Duration(milliseconds: 400),
              child: Container(
                height: barHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0),
                      Color.fromRGBO(0, 0, 0, 0.5),
                    ],
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    // ?????? - ??????/??????
                    // _buildPlayStateBtn(),
                    // ???????????????
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 16),
                      child: SizedBox(
                        width: 50,
                        child: Text(
                          _duration2String(_currentPos),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    showConfig.liveMode
                        ? Text(
                            '??????',
                            style: TextStyle(color: Colors.white),
                          )
                        : Container(),
                    // ???????????? if ?????????????????? ????????????ui??? else fijkSlider widget
                    showConfig.liveMode
                        ? Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Container(
                                  width: double.infinity,
                                )),
                          )
                        : _duration.inMilliseconds == 0
                            ? Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: NewFijkSlider(
                                    colors: NewFijkSliderColors(
                                      cursorColor: MColors.primiaryColor,
                                      playedColor: MColors.primiaryColor,
                                    ),
                                    onChangeEnd: (double value) {},
                                    value: 0,
                                    onChanged: (double value) {},
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: NewFijkSlider(
                                    colors: NewFijkSliderColors(
                                      cursorColor: MColors.primiaryColor,
                                      playedColor: MColors.primiaryColor,
                                    ),
                                    value: currentValue,
                                    cacheValue:
                                        _bufferPos.inMilliseconds.toDouble(),
                                    min: 0.0,
                                    max: duration,
                                    onChanged: (v) {
                                      _startHideTimer();
                                      setState(() {
                                        _seekPos = v;
                                      });
                                    },
                                    onChangeEnd: (v) {
                                      setState(() {
                                        player.seekTo(v.toInt());
                                        // ignore: avoid_print
                                        print("seek to $v");
                                        _currentPos = Duration(
                                            milliseconds: _seekPos.toInt());
                                        _seekPos = -1;
                                      });
                                    },
                                  ),
                                ),
                              ),

                    // ???????????????
                    showConfig.liveMode
                        ? Container()
                        : _duration.inMilliseconds == 0
                            ? const Text(
                                "00:00",
                                style: TextStyle(color: Colors.white),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(right: 5.0, left: 5),
                                child: Text(
                                  _duration2String(_duration),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                    // ????????????
                    widget.player.value.fullScreen && showConfig.speedBtn
                        ? Ink(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _hideSpeedStu = !_hideSpeedStu;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 30,
                                child: Text(
                                  _speed.toString() + " X",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    // ?????? - ??????/????????????
                    IconButton(
                      icon: Icon(widget.player.value.fullScreen
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        if (widget.player.value.fullScreen) {
                          player.exitFullScreen();
                        } else {
                          player.enterFullScreen();
                        }
                      },
                    )
                    //
                  ],
                ),
              ),
            ),
          ),
          // ??????????????????ui???????????????
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: showConfig.bottomPro &&
                    _hideStuff &&
                    _duration.inMilliseconds != 0
                ? Container(
                    alignment: Alignment.bottomLeft,
                    height: 2,
                    color: Colors.white70,
                    child: Container(
                      color: MColors.primiaryColor,
                      width: curBottomProW,
                      height: 2,
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  // ????????????
  Widget _buildTopBackBtn() {
    return IconButton(
      icon: const Icon(IconFonts.iconFanhui),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.white,
      onPressed: () {
        // ????????????????????????????????????????????????
        if (widget.player.value.fullScreen) {
          player.exitFullScreen();
        } else {
          if (widget.pageContent == null) return;
          player.stop();
          Navigator.pop(widget.pageContent!);
        }
      },
    );
  }

  // ??????????????? ?????? + ??????
  Widget _buildTopBar() {
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 0.8,
      duration: const Duration(milliseconds: 400),
      child: Container(
        // height: showConfig.stateAuto && !widget.player.value.fullScreen
        //     ? barFillingHeight
        //     : barHeight,
        alignment: Alignment.bottomLeft,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.5),
              Color.fromRGBO(0, 0, 0, 0),
            ],
          ),
        ),
        child: Row(
          children: <Widget>[
            _buildTopBackBtn(),
            Expanded(
              child: Text(
                playTitle.value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Offstage(
              offstage: !widget.player.value.fullScreen,
              child: InkWell(
                onTap: _showVideos,
                child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Text(
                      '??????',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ??????????????????
  Widget _buildCenterPlayBtn() {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: (_prepared && !_buffering)
            ? AnimatedOpacity(
                opacity: _hideStuff ? 0.0 : 0.7,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(barHeight * 1.2)),
                    color: Colors.black45,
                  ),
                  child: IconButton(
                    iconSize: barHeight * 0.8,
                    icon: Icon(_playing ? Icons.pause : Icons.play_arrow,
                        color: Colors.white),
                    // padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    onPressed: _playOrPause,
                  ),
                ),
              )
            : const SizedBox(
                width: barHeight * 0.8,
                height: barHeight * 0.8,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
      ),
    );
  }

  // build ????????????????????????
  Widget _buildDargProgressTime() {
    return _isTouch
        ? Container(
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Color.fromRGBO(0, 0, 0, 0.8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${_duration2String(_dargPos)} / ${_duration2String(_duration)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        : Container();
  }

  // build ???????????????????????????
  Widget _buildDargVolumeAndBrightness() {
    // ?????????
    if (!varTouchInitSuc) return Container();

    IconData iconData;
    // ???????????????????????????????????????
    if (updateDargVarVal! <= 0) {
      iconData = !isDargVerLeft! ? Icons.volume_mute : Icons.brightness_low;
    } else if (updateDargVarVal! < 0.5) {
      iconData = !isDargVerLeft! ? Icons.volume_down : Icons.brightness_medium;
    } else {
      iconData = !isDargVerLeft! ? Icons.volume_up : Icons.brightness_high;
    }
    // ??????????????? || ??????
    return Card(
      color: const Color.fromRGBO(0, 0, 0, 0.8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.white,
            ),
            Container(
              width: 100,
              height: 3,
              margin: const EdgeInsets.only(left: 8),
              child: LinearProgressIndicator(
                value: updateDargVarVal,
                backgroundColor: Colors.white54,
                valueColor: const AlwaysStoppedAnimation(Colors.lightBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // build ????????????
  List<Widget> _buildSpeedListWidget() {
    List<Widget> columnChild = [];
    speedList.forEach((String mapKey, double speedVals) {
      columnChild.add(
        Ink(
          child: InkWell(
            onTap: () {
              if (_speed == speedVals) return;
              setState(() {
                _speed = speed = speedVals;
                _hideSpeedStu = true;
                player.setSpeed(speedVals);
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 50,
              child: Text(
                mapKey + " X",
                style: TextStyle(
                  color: _speed == speedVals
                      ? MColors.primiaryColor
                      : Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );
      columnChild.add(
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            width: 50,
            height: .5,
            color: Colors.white54,
          ),
        ),
      );
    });
    columnChild.removeAt(columnChild.length - 1);
    return columnChild;
  }

  // ?????????????????? ui
  Widget _buildGestureDetector() {
    return GestureDetector(
      onTap: _cancelAndRestartTimer,
      onDoubleTap: _playOrPause,
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      onLongPressStart: (context) {
        setState(() {
          if (showConfig.liveMode == false) {
            _speed = speed = 2.0;
            _isSpeed = true;
            player.setSpeed(2.0);
          }
        });
      },
      onLongPressEnd: (context) {
        setState(() {
          if (showConfig.liveMode == false) {
            _isSpeed = false;
            _speed = speed = 1.0;
            player.setSpeed(1.0);
          }
        });
      },
      child: AbsorbPointer(
        absorbing: _hideStuff,
        child: Column(
          children: <Widget>[
            // ????????????????????????
            showConfig.topBar || widget.player.value.fullScreen
                ? _buildTopBar()
                : Container(
                    height:
                        showConfig.stateAuto && !widget.player.value.fullScreen
                            ? barFillingHeight
                            : barHeight,
                  ),
            // ????????????
            Expanded(
              child: Stack(
                children: <Widget>[
                  // ????????????
                  Positioned(
                    top: widget.player.value.fullScreen ? 20 : 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ????????????????????????????????????
                        _buildDargProgressTime(),
                        // ??????????????????????????????
                        _buildDargVolumeAndBrightness()
                      ],
                    ),
                  ),

                  //?????????
                  Positioned(
                      top: 0,
                      left: 32,
                      child: Offstage(
                        offstage: !_isSpeed,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10)),
                          child: MText(
                            '2X?????????',
                            color: Colors.white,
                          ),
                        ),
                      )),
                  // ????????????
                  Align(
                    alignment: Alignment.center,
                    child: _buildCenterPlayBtn(),
                  ),
                  // ????????????
                  Positioned(
                    right: 35,
                    bottom: 0,
                    child: !_hideSpeedStu
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: _buildSpeedListWidget(),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        : Container(),
                  ),
                  // ?????????
                  showConfig.lockBtn && widget.player.value.fullScreen
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedOpacity(
                            opacity: _hideStuff ? 0.0 : 0.7,
                            duration: const Duration(milliseconds: 400),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  // ?????? ui????????????
                                  widget.changeLockState(true);
                                },
                                icon: const Icon(Icons.lock_outline),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            // ????????????????????????
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGestureDetector();
  }
}
