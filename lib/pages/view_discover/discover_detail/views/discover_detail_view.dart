import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/common/m_player.dart';
import 'package:mvideo/widgets/common/m_send_box.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/text/m_double_text.dart';
import '../controllers/discover_detail_controller.dart';

class DiscoverDetailView extends GetView<DiscoverDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.blackBackground,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MColors.blackBackground,
      ),
      body: Stack(
        children: [
          Column(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    MIcon(
                      IconFonts.iconFanhui,
                      color: MColors.blackTipColor,
                      onTap: () => Get.back(),
                    ),
                    Expanded(
                      child: MListTile(
                        url:
                            'https://img2.baidu.com/it/u=1052567076,3275246168&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
                        title: '我的快点咯撒是快点咯撒',
                        subtitle: '123关注',
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        titleColor: MColors.white,
                        subtitleColor: MColors.blackTipColor,
                        trailing: MButton(
                          label: '关注',
                          width: 64,
                          height: 32,
                          bgColor: MColors.primiaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                color: MColors.black,
                child: MPlayer(
                  width: Get.width,
                  height: Get.width * 9 / 16,
                  player: controller.player,
                  curPlayUrl: controller.gg,
                  showConfig: controller.discoverShowConfig,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MText(
                      '变形金刚',
                      color: MColors.white,
                      size: 18,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        MDoubleText(
                          icon: IconFonts.iconLiulan,
                          value: '111 次观看',
                          lableColor: MColors.blackTipColor,
                          labelSize: 16,
                          valueSize: 12,
                          valueColor: MColors.blackTipColor,
                        ),
                        SizedBox(width: 24),
                        MDoubleText(
                          icon: IconFonts.iconDianzan2,
                          value: '1231 赞',
                          lableColor: MColors.blackTipColor,
                          labelSize: 14,
                          valueSize: 12,
                          valueColor: MColors.blackTipColor,
                        ),
                        SizedBox(width: 24),
                        Obx(() => MDoubleText(
                              icon: Icons.person,
                              value: '${controller.people.value} 人',
                              lableColor: MColors.blackTipColor,
                              labelSize: 14,
                              valueSize: 12,
                              valueColor: MColors.blackTipColor,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Divider(height: 1, color: MColors.blackTipColor),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Row(
                          textDirection: index == 4
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MAvatar(
                              'https://img0.baidu.com/it/u=4183146585,2121935578&fm=26&fmt=auto',
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child: Column(
                              textDirection: index == 4
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MText(
                                  '阿西吧',
                                  color: MColors.white,
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: MColors.blackBackground1,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  index == 4 ? 10 : 0),
                                              topRight: Radius.circular(
                                                  index == 4 ? 0 : 10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10))),
                                      child: MText(
                                        controller.msgList[index],
                                        color: MColors.blackTipColor,
                                        maxLines: 10,
                                      ),
                                    )),
                                SizedBox(height: 8),
                              ],
                            )),
                          ],
                        ),
                      );
                    },
                    itemCount: controller.msgList.length,
                  ),
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
          Positioned(
              bottom: 0,
              child: MSendBox(
                bgColor: Color(0xFF252836),
                placeholderColor: MColors.blackTipColor,
                inputBgColor: MColors.black,
                inputColor: MColors.white,
                cursorColor: MColors.white,
                submitWidget: MIcon(
                  IconFonts.iconSend,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  color: MColors.blackTipColor,
                  size: 20,
                  onTap: controller.onSumbit,
                ),
              )),
          Positioned(
            top: 200,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width *
                    MediaQuery.of(context).size.aspectRatio +
                200,
            child: BarrageWall(
              controller: controller.barrageWallController,
              massiveMode: false,
              child: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
