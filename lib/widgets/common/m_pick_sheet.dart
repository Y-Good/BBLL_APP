import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class PickItem {
  IconData? icon;
  String? label;
  ImageSource? pickType;
  PickItem({this.icon, this.label, this.pickType});
}

class MPickSheet extends StatelessWidget {
  final ValueChanged<ImageSource>? onTap;

  MPickSheet({Key? key, this.onTap}) : super(key: key);

  final List<PickItem> pickList = [
    PickItem(icon: Icons.photo, label: '相册 ', pickType: ImageSource.gallery),
    PickItem(icon: Icons.camera, label: '相机  ', pickType: ImageSource.camera)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          2,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MIcon(
                pickList[index].icon!,
                size: 64,
                color: Colors.orangeAccent,
                onTap: () => onTap!(pickList[index].pickType!),
              ),
              MText(pickList[index].label ?? '')
            ],
          ),
        ),
      ),
    );
  }
}
