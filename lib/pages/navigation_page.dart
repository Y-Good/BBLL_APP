import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/fonts/m_iconfont.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/pages/public.dart';
import 'package:mvideo/pages/upload/views/upload_view.dart';
import 'package:mvideo/routes/app_pages.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    FindView(),
    UploadView(),
    LiveView(),
    UserView(),
  ];
  final List<SalomonBottomBarItem> bottomNavBarItems = [
    SalomonBottomBarItem(icon: Icon(IconFonts.iconShouye), title: Text("首页")),
    SalomonBottomBarItem(icon: Icon(IconFonts.iconXitong), title: Text("发现")),
    SalomonBottomBarItem(
        icon: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            decoration: BoxDecoration(
                color: MColors.primiaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        title: Container()),
    SalomonBottomBarItem(icon: Icon(IconFonts.iconLive), title: Text("直播")),
    SalomonBottomBarItem(icon: Icon(IconFonts.iconWode), title: Text("我的")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: _currentIndex, children: pages),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          itemPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          selectedItemColor: Colors.black,
          onTap: (int index) {
            setState(() {
              if (index == 2) {
                Get.toNamed(Routes.UPLOAD);
              } else {
                _currentIndex = index;
              }
            });
          },
          items: bottomNavBarItems,
        ));
  }
}
