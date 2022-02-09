import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/pages/home/controllers/home_controller.dart';
import 'package:mvideo/pages/public.dart';

class HotPage extends GetView<HomeController> {
  const HotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotFoundView();
  }
}
