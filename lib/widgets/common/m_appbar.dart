import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';

class MAppBar extends AppBar {
  MAppBar(
      {Key? key,
      String? title,
      Widget? titleWidget,
      Widget? actionWidget,
      //显示leading
      bool isLeading = true,
      //按钮文本切换
      bool isText = false,
      double? elevation = 0,
      Color color = Colors.black,
      Color? bgcolor = Colors.white,
      Widget? leading,
      VoidCallback? onTap,
      List<Widget>? actions,
      double? toolbarHeight,
      PreferredSizeWidget? bottom})
      : super(
            key: key,
            title: titleWidget ??
                Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    color: color,
                  ),
                ),
            centerTitle: true,
            toolbarHeight: toolbarHeight ?? 44,
            // leadingWidth: 50,
            elevation: elevation,
            backgroundColor: bgcolor,
            // brightness: Brightness.dark,
            leading: isLeading
                ? leading ??
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        IconFonts.iconFanhui,
                        color: Colors.black,
                        size: 24,
                      ),
                    )
                : null,
            actions: actions ??
                [
                  Padding(
                    padding: const EdgeInsets.only(right: 16, top: 10),
                    child: actionWidget,
                  )
                ],
            bottom: bottom);
}
