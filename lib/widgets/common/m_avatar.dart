import 'package:flutter/material.dart';

const double _MSize = 40;

class MAvatar extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? radius;

  final VoidCallback? onTap;
  const MAvatar(this.url,
      {Key? key, this.width, this.height, this.radius, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? _MSize,
        height: height ?? _MSize,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(radius ?? ((width ?? _MSize) / 2)),
            image: DecorationImage(image: NetworkImage(url))),
      ),
    );
  }
}
