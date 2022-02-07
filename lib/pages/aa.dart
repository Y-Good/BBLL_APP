import 'package:flutter/material.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int indexs = 0;
  List<Widget> jj = [
    Icon(IconFonts.iconLive),
    Icon(IconFonts.iconWode),
    Icon(IconFonts.iconWode),
    Icon(IconFonts.iconWode),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            jj.length,
            (index) => InkWell(
                  child: jj[index],
                  hoverColor: Colors.pink,
                  onTap: () {
                    indexs = index;
                    print(indexs);
                    setState(() {});
                  },
                )),
      ),
    );
  }
}
