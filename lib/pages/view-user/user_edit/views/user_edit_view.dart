import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/widgets/public.dart';
import '../controllers/user_edit_controller.dart';

class UserEditView extends GetView<UserEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        title: '编辑资料',
        actionWidget: MIcon(
          Icons.check,
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Text(
          'UserEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
