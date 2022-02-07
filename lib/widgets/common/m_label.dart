import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MLabel extends StatelessWidget {
  final String label;
  const MLabel(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: MColors.primiaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: MText(
          label,
          size: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
