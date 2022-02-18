import 'package:flutter/material.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/public.dart';

class MDoubleText extends StatelessWidget {
  final String value;
  final String? label;
  final IconData? icon;
  final Color? lableColor;
  final Color? valueColor;
  final double? labelSize;
  final double? valueSize;
  const MDoubleText(
      {Key? key,
      this.label,
      required this.value,
      this.lableColor,
      this.valueColor,
      this.labelSize,
      this.valueSize,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        label == null
            ? MIcon(icon ?? Icons.add, size: labelSize, color: lableColor)
            : MText(label ?? '', color: lableColor, size: labelSize),
        SizedBox(width: 4),
        MText(value, color: valueColor, size: valueSize)
      ],
    );
  }
}
