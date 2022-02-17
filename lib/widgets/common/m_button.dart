import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? size;
  final Color? color;
  final Color? bgColor;
  final double? radius;
  final Widget? child;
  final BoxBorder? border;

  const MButton({
    Key? key,
    this.label,
    this.onTap,
    this.width,
    this.height = 40,
    this.size,
    this.bgColor,
    this.radius,
    this.child,
    this.color,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          decoration: BoxDecoration(
              border: border,
              color: bgColor ?? MColors.primiaryColor,
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 10))),
          child: child ??
              MText(
                label ?? '',
                size: size,
                color: color ?? Colors.white,
              ),
        ));
  }
}
