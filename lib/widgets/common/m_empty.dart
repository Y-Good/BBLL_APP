import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvideo/widgets/public.dart';

class MEmpty extends StatelessWidget {
  final String? text;
  const MEmpty({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          child: SvgPicture.asset(
            'assets/svg/empty.svg',
          ),
        ),
        SizedBox(height: 10),
        MText(
          text ?? '暂无数据',
          color: Colors.grey,
        )
      ],
    ));
  }
}
