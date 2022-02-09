import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/common/m_avatar.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MListTile extends StatelessWidget {
  final String? url;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final Color? backgroundColor;

  const MListTile(
      {Key? key,
      this.title,
      this.subtitle,
      this.url,
      this.trailing,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 56,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MAvatar(url ?? ''),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MText(title ?? '-'),
                  SizedBox(height: 4),
                  MText(
                    subtitle ?? '-',
                    size: 12,
                    color: MColors.grey6,
                  ),
                ],
              ),
            ],
          ),
          trailing ?? SizedBox(width: 0)
        ],
      ),
    );
  }
}
