import 'package:flutter/material.dart';

class MEmpty extends StatelessWidget {
  const MEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '😓😓',
        style: TextStyle(fontSize: 36),
      ),
    );
  }
}
