import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class MPlayer extends StatelessWidget {
  final FijkPlayer player;
  final ShowConfigAbs? showConfig;
  final String? curPlayUrl;
  final String? cover;
  final Widget? customSkin;
  final double? width;
  final double? height;
  final FijkFit? fit;
  final String? title;
  const MPlayer({
    Key? key,
    required this.player,
    this.showConfig,
    this.curPlayUrl,
    this.cover,
    this.customSkin,
    this.width,
    this.height,
    this.fit,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FijkView(
      color: Colors.black,
      height: height,
      width: width,
      fit: fit ?? FijkFit.contain,
      player: player,
      cover: cover != null ? NetworkImage(cover!) : null,
      panelBuilder: (
        FijkPlayer player,
        FijkData data,
        BuildContext context,
        Size viewSize,
        Rect texturePos,
      ) {
        return customSkin ??
            CustomFijkPanel(
              player: player,
              playerTitle: title ?? '',
              viewSize: viewSize,
              texturePos: texturePos,
              pageContent: context,
              showConfig: showConfig ?? VideoShowConfig(),
              curPlayUrl: curPlayUrl ?? '',
            );
      },
    );
  }
}
