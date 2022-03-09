import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notify_controller.dart';

class NotifyView extends GetView<NotifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotifyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotifyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
