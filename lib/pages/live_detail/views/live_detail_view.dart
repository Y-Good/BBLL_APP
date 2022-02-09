import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/config/color/m_colors.dart';
import 'package:mvideo/widgets/public.dart';

import '../controllers/live_detail_controller.dart';

class LiveDetailView extends GetView<LiveDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            // physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            slivers: [
              SliverAppBar(
                elevation: 0,
                pinned: true,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                      splashColor: Colors.transparent)
                ],
                backgroundColor: Colors.black,
                flexibleSpace: Image.network(
                    "https://img1.baidu.com/it/u=2782121391,3115389701&fm=253&fmt=auto&app=138&f=PNG?w=500&h=281"),
                // expandedHeight: 230,
                collapsedHeight: Get.size.width * 9 / 16,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MIconText(icon: Icons.person, text: "100人"),
                ),
              ),
              SliverToBoxAdapter(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: MText("text"),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 48,
                width: Get.size.width,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: MInput(
                          // textEditingController: controller.contentController,
                          bgColor: MColors.backgroundColor,
                          height: 32,
                          // onChange: (value) => controller.content = value,
                        ),
                      )),
                      MText(
                        '发布',
                        // color: controller.isText.value
                        //     ? MColors.primiaryColor
                        //     : Colors.grey,
                        // onTap: () => controller.submit(),
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
