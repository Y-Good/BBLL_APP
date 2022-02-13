import 'package:flutter/material.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/public.dart';

class MBottomBarItem {
  Widget icon;
  String? title;
  MBottomBarItem({required this.icon, this.title});
}

class MBottomBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MBottomBarItem> items;
  const MBottomBar({Key? key, required this.currentIndex, required this.onTap, required this.items}) : super(key: key);

  @override
  _MBottomBarState createState() => _MBottomBarState();
}

class _MBottomBarState extends State<MBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(width: .5, color: Colors.grey.withOpacity(0.3)))),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 32),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            widget.items.length,
            (index) => InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconTheme(
                          data: IconThemeData(
                            color: widget.items.indexOf(widget.items[index]) == _currentIndex ? MColors.primiaryColor : Colors.black,
                            size: 24,
                          ),
                          child: widget.items[index].icon),
                      widget.items[index].title != null
                          ? MText(
                              widget.items[index].title ?? '',
                              color: widget.items.indexOf(widget.items[index]) == _currentIndex ? MColors.primiaryColor : Colors.black,
                              size: 10,
                            )
                          : SizedBox()
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                    widget.onTap(index);
                  },
                )),
      ),
    );
  }
}
