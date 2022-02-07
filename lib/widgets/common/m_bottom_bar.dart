import 'package:flutter/material.dart';

class MBottomBar extends StatelessWidget {
  final ValueChanged<int>? onTap;
  const MBottomBar({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            List.generate(4, (index) => GestureDetector(child: Text("data"))),
      ),
    );
  }
}
