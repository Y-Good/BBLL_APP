import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MLabel extends StatelessWidget {
  final String label;
  final double? size;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? radius;
  const MLabel(this.label,
      {Key? key, this.size, this.color, this.onTap, this.radius, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 16,
        constraints: BoxConstraints(minHeight: 16),
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: color ?? MColors.primiaryColor,
        ),
        child: MText(
          label,
          size: size ?? 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
