import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/pages/public.dart';
import 'package:mvideo/pages/view-user/user/views/user_view.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:mvideo/widgets/public.dart';

class MBottomNavigationBarPage extends StatefulWidget {
  final int? indexs;
  const MBottomNavigationBarPage({Key? key, this.indexs}) : super(key: key);

  @override
  _MBottomNavigationBarPageState createState() =>
      _MBottomNavigationBarPageState();
}

class _MBottomNavigationBarPageState extends State<MBottomNavigationBarPage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    HomeView(),
    DiscoverView(),
    Container(),
    LiveView(),
    UserView(),
  ];
  final List<MBottomBarItem> bottomNavBarItems = [
    MBottomBarItem(icon: Icon(IconFonts.iconShouye), title: "首页"),
    MBottomBarItem(icon: Icon(IconFonts.iconXitong), title: "发现"),
    MBottomBarItem(
      icon: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              color: MColors.primiaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Icon(
            Icons.add,
            color: MColors.white,
          )),
    ),
    MBottomBarItem(icon: Icon(IconFonts.iconLive), title: "直播"),
    MBottomBarItem(icon: Icon(IconFonts.iconWode), title: "我的"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: _currentIndex, children: pages),
        bottomNavigationBar: MBottomBar(
          currentIndex: _currentIndex,
          items: bottomNavBarItems,
          bgColor: _currentIndex == 1 ? Color(0xFF252836) : null,
          selectColor: _currentIndex == 1 ? MColors.white : null,
          unselectColor: _currentIndex == 1 ? MColors.blackTipColor : null,
          onTap: (int index) {
            setState(() {
              if (index == 2) {
                // _currentIndex = _currentIndex;
                Get.toNamed(Routes.UPLOAD);
              } else {
                _currentIndex = index;
              }
            });
          },
        ));
  }
}
