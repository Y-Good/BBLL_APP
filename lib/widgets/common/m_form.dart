import 'package:flutter/material.dart';

class MForm extends StatelessWidget {
  const MForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [TextFormField()],
      ),
    );
  }
}
