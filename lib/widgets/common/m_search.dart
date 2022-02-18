import 'package:flutter/material.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/config/color/m_colors.dart';

class MSearch extends StatelessWidget {
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  const MSearch(
      {Key? key, this.enabled = true, this.focusNode, this.autofocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: MColors.background,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: TextField(
        maxLines: 1,
        focusNode: focusNode,
        autofocus: true,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.grey,
        style: TextStyle(
            color: Colors.black,
            textBaseline: TextBaseline.alphabetic,
            fontSize: 14),
        decoration: InputDecoration(
            enabled: enabled,
            isCollapsed: true,
            contentPadding: EdgeInsets.only(left: -12),
            hintText: '搜索好友',
            border: InputBorder.none,
            prefixStyle: TextStyle(color: Colors.black),
            icon: Icon(
              IconFonts.iconSousuo,
              size: 24,
              color: Colors.grey,
            )),
      ),
    );
  }
}
