import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final Color? bgColor;
  final Color? selectColor;
  final Color? unselectColor;
  const MBottomBar(
      {Key? key,
      required this.currentIndex,
      required this.onTap,
      required this.items,
      this.bgColor,
      this.selectColor,
      this.unselectColor})
      : super(key: key);

  @override
  _MBottomBarState createState() => _MBottomBarState();
}

class _MBottomBarState extends State<MBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor ?? Colors.white,
          border: Border(
              top: BorderSide(width: .3, color: Colors.grey.withOpacity(0.2)))),
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.symmetric(horizontal: 32),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            widget.items.length,
            (index) => InkWell(
                  child: Container(
                    width: Get.width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconTheme(
                            data: IconThemeData(
                              color:
                                  widget.items.indexOf(widget.items[index]) ==
                                          _currentIndex
                                      ? widget.selectColor ?? Colors.black
                                      : widget.unselectColor ?? Colors.grey,
                              size: 24,
                            ),
                            child: widget.items[index].icon),
                        widget.items[index].title != null
                            ? MText(
                                widget.items[index].title ?? '',
                                color:
                                    widget.items.indexOf(widget.items[index]) ==
                                            _currentIndex
                                        ? widget.selectColor ?? Colors.black
                                        : widget.unselectColor ?? Colors.grey,
                                size: 10,
                              )
                            : SizedBox()
                      ],
                    ),
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
