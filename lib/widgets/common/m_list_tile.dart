import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/common/m_avatar.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MListTile extends StatelessWidget {
  final String? url;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? subtitleColor;
  final Color? titleColor;
  final double? titleSize;
  final VoidCallback? onTap;

  const MListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.titleSize,
    this.url,
    this.trailing,
    this.backgroundColor,
    this.padding,
    this.subtitleColor,
    this.titleColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MAvatar(url ?? ''),
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MText(
                      title ?? '-',
                      color: titleColor,
                      size: titleSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    MText(
                      subtitle ?? '-',
                      size: 12,
                      color: subtitleColor ?? MColors.grey6,
                    ),
                  ],
                ),
              ],
            ),
          ),
          trailing ?? SizedBox(width: 0)
        ],
      ),
    );
  }
}
