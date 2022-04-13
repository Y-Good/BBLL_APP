import 'package:flutter/material.dart';

class MText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final VoidCallback? onTap;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const MText(
    this.text, {
    Key? key,
    this.size = 14,
    this.color = Colors.black,
    this.style,
    this.onTap,
    this.maxLines = 1,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
        style: style ?? TextStyle(fontSize: size, color: color),
      ),
    );
  }
}
