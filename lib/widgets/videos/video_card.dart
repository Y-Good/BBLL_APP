import 'package:flutter/material.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/models/video_model.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class VideoCard extends StatelessWidget {
  final Video? video;
  final VoidCallback? onTap;
  const VideoCard({Key? key, this.onTap, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                          'https://img2.baidu.com/it/u=3893441224,507443731&fm=26&fmt=auto'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.only(top: 16, right: 8, left: 8),
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
                                IconFonts.iconBofangqiBofang,
                                size: 12,
                                color: Colors.white,
                              ),
                              MText(
                                transformView(video?.views ?? 0),
                                size: 10,
                                color: Colors.white,
                              )
                            ],
                          ),
                          MText(
                            "2:34",
                            size: 10,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ))
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
                      video?.author ?? '-',
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
