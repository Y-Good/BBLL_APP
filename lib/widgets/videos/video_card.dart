import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvideo/common/enums/video_mode_enum.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/utils/video_utils.dart';
import 'package:mvideo/widgets/common/m_empty.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class VideoCard extends StatelessWidget {
  final Video? video;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isLive;
  final VideoMode? videoMode;
  const VideoCard({
    Key? key,
    this.onTap,
    this.onLongPress,
    this.video,
    this.isLive = false,
    this.videoMode = VideoMode.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      // height: 100,
                      width: double.infinity,
                      image: NetworkImage(
                          CommonUtils.handleSrcUrl(video?.cover ?? '')),
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, Object exception, StackTrace? stackTrace) {
                        return Container(
                            width: double.infinity,
                            color: MColors.white,
                            child: SvgPicture.asset(Msvg.img));
                      },
                      // loadingBuilder: (context, Widget child, loadingProgress) {
                      //   return Container(
                      //     width: double.infinity,
                      //     color: MColors.grey9.withOpacity(0.3),
                      //     child: child,
                      //   );
                      // },
                    ),
                  ),
                )),
                videoMode == VideoMode.live
                    ? Container()
                    : Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            right: 8,
                            left: 8,
                            bottom: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Color(0x00ababab)],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconFonts.iconLiulan,
                                    size: 12,
                                    color: MColors.white,
                                  ),
                                  SizedBox(width: 2),
                                  MText(
                                    transformView(
                                        int.parse(video?.view ?? '0')),
                                    size: 10,
                                    color: MColors.white,
                                  )
                                ],
                              ),
                              MText(
                                VideoUtils.duration2String(
                                    int.parse(video?.duration ?? '0')),
                                size: 10,
                                color: MColors.white,
                              )
                            ],
                          ),
                        )),

                ///直播遮罩
                videoMode == VideoMode.live && isLive == false
                    ? Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Container(
                          color: Colors.black54,
                          child: Center(
                              child: MText(
                            '未开播',
                            color: Colors.white70,
                          )),
                        ))
                    : Container(),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 176 / 61,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MText(
                      video?.title ?? '-',
                      size: 12,
                      maxLines: 2,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    MText(
                      video?.user?.nickname ?? '-',
                      size: 10,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
