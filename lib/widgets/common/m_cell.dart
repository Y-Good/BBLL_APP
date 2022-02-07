import 'package:flutter/material.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MCell extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final Widget? trailing;
  final Widget? title;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const MCell(
      {Key? key,
      this.icon,
      this.title,
      this.trailing,
      this.onTap,
      this.label,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 48,
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ...isNotNull(icon)
                    ? [
                        Icon(icon, size: 24),
                        SizedBox(width: 8),
                      ]
                    : [],
                MText(label ?? '')
              ],
            ),
            Expanded(child: title ?? SizedBox(width: 0)),
            trailing ??
                Icon(
                  IconFonts.iconRight1Copy,
                  color: Colors.grey,
                  size: 24,
                )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
