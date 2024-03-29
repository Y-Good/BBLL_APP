import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/config/http/request/user_request.dart';
import 'package:mvideo/pages/public.dart';

import 'routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

/// 测试实施
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: MColors.background,
          primarySwatch: MColors.materialWhite,
        ),
        builder: EasyLoading.init(),
        initialRoute: AppPages.INITIAL,
        onInit: () async {
          // await FlutterDisplayMode.setHighRefreshRate();
          UserRequest.getUserInfo();
        },
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
        unknownRoute: GetPage(name: "/notfound", page: () => NotFoundView()));
  }
}
