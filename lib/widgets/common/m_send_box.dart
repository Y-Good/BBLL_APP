import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/widgets/public.dart';

class MSendBox extends StatelessWidget {
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChange;
  final VoidCallback? onSubmit;
  final bool changeColor;
  final Widget? submitWidget;
  final Color? bgColor;
  final Color? inputColor;
  final Color? inputBgColor;
  final Color? placeholderColor;
  final Color? cursorColor;
  final String? placeholder;

  const MSendBox(
      {Key? key,
      this.textEditingController,
      this.onChange,
      this.onSubmit,
      this.changeColor = false,
      this.submitWidget,
      this.bgColor,
      this.inputColor,
      this.inputBgColor,
      this.placeholderColor,
      this.placeholder,
      this.cursorColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 56,
      alignment: Alignment.center,
      width: Get.size.width,
      color: bgColor ?? MColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
              child: MInput(
                textEditingController: textEditingController,
                bgColor: inputBgColor ?? MColors.background,
                inputColor: inputColor,
                cursorColor: cursorColor,
                placeholder: placeholder,
                placeholderColor: placeholderColor,
                height: 32,
                onChange: onChange,
              ),
            )),
            submitWidget ??
                MText(
                  '发布',
                  color: changeColor ? MColors.primiaryColor : Colors.grey,
                  onTap: onSubmit,
                )
          ]),
    );
  }
}
