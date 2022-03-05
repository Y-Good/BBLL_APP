import 'package:flutter/material.dart';

const double _MSize = 40;

class MAvatar extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? radius;
  final VoidCallback? onTap;
  final ImageProvider<Object>? image;
  const MAvatar(this.url,
      {Key? key, this.width, this.height, this.radius, this.onTap, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? _MSize,
        height: height ?? _MSize,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(radius ?? ((width ?? _MSize) / 2)),
          child: Image(
            // height: 100,
            width: double.infinity,
            image: image ?? NetworkImage(url),
            fit: BoxFit.cover,
            errorBuilder: (context, Object exception, StackTrace? stackTrace) {
              return Image.asset('assets/avatar/default.jpg');
            },
          ),
        ),
      ),
    );
  }
}
