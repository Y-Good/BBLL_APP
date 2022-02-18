import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FindView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'FindView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
