import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class MSwiper extends StatelessWidget {
  const MSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16 / 7,
          child: Swiper(
            autoplay: true,
            pagination: SwiperPagination(alignment: Alignment.bottomRight),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                      image: NetworkImage(
                          'https://img1.baidu.com/it/u=4139035421,3795625589&fm=26&fmt=auto'),
                      fit: BoxFit.cover),
                ),
              );
            },
            itemCount: 4,
          ),
        ));
  }
}
