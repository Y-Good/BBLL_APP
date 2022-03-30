import 'package:flutter/material.dart';
import 'package:mvideo/widgets/public.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MEmpty(
      text: '还没动工',
      type: Msvg.build,
    );
  }
}
