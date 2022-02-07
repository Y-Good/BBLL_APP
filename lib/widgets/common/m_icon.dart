import 'package:flutter/material.dart';

class MIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  const MIcon(this.icon,
      {Key? key, this.size, this.color, this.onTap, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.all(0),
        child: Icon(
          icon,
          color: color,
          size: size ?? 24,
        ),
      ),
    );
  }
}
