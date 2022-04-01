import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvideo/widgets/public.dart';

class Msvg {
  static String build = "assets/svg/build.svg";
  static String search = "assets/svg/search.svg";
  static String empty = "assets/svg/empty.svg";
  static String upload = "assets/svg/upload.svg";
  static String img = "assets/svg/img.svg";
  static String empty2 = "assets/svg/empty2.svg";
}

class MEmpty extends StatelessWidget {
  final String? text;
  final String? type;
  const MEmpty({Key? key, this.text, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          child: SvgPicture.asset(
            type ?? Msvg.empty2,
          ),
        ),
        SizedBox(height: 5),
        MText(
          text ?? '暂无数据',
          color: Colors.grey,
        )
      ],
    ));
  }
}
