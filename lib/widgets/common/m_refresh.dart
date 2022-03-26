import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/public.dart';

class MRefresh extends StatelessWidget {
  final Widget child;
  final VoidCallback? onRefresh;
  final bool isEmpty;
  final EasyRefreshController? controller;
  const MRefresh(
      {Key? key,
      required this.child,
      this.onRefresh,
      this.controller,
      this.isEmpty = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        controller: controller,
        onRefresh: () async => onRefresh!(),
        header: MaterialHeader(
          enableHapticFeedback: true,
          backgroundColor: MColors.primiaryColor,
        ),
        emptyWidget: isEmpty ? MEmpty() : null,
        child: child);
  }
}
