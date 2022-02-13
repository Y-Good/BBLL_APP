import 'package:flutter/material.dart';
import 'package:mvideo/widgets/public.dart';

class MDoubleText extends StatelessWidget {
  final String label;
  final String value;
  final Color? lableColor;
  final Color? valueColor;
  const MDoubleText(
      {Key? key, required this.label, required this.value, this.lableColor, this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MText(label, color: lableColor),
        SizedBox(width: 4),
        MText(value, color: valueColor)
      ],
    );
  }
}
