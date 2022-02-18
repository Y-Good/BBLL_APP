import 'package:flutter/material.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class SearchVideoPage extends StatelessWidget {
  const SearchVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: 8, bottom: index == 19 ? 8 : 0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Image.network(
                    'http://img.netbian.com/file/2021/1219/small2155455WXHD1639922145.jpg',
                    height: 80,
                    fit: BoxFit.cover,
                    width: 80 * 16 / 9,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MText(
                          "页面中间的加载框，可以配置显示置显示置显示置显示置显示的文字。",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        // SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MText(
                              "倔强的小强",
                              color: MColors.grey9,
                              size: 10,
                            ),
                            // MText(
                            //   "2020-12-32",
                            //   color: MColors.grey9,
                            //   size: 10,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MIconText(
                                  icon: IconFonts.iconBofangqiBofang,
                                  iconSize: 14,
                                  textSize: 12,
                                  text: '123万',
                                ),
                                MText(
                                  '12-12',
                                  size: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }
}
