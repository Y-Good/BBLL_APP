import 'package:flutter/material.dart';
import 'package:mvideo/widgets/common/m_appbar.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        title: "404",
      ),
    );
  }
}
