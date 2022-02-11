import 'package:flutter/material.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MIconText extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  const MIconText({Key? key, this.onTap, this.icon, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: color ?? Colors.grey,
              ),
              MText(
                text ?? '',
                color: color ?? Colors.grey,
              ),
            ],
          ),
        ));
  }
}
