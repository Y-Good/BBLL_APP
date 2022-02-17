import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvideo/utils/utils.dart';
import 'package:mvideo/widgets/text/m_text.dart';

class MInput extends StatelessWidget {
  final String? label;
  final double? height;
  final Color? bgColor;
  final Axis direction;
  final String? placeholder;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChange;
  final TextAlign textAlign;
  const MInput({
    Key? key,
    this.textEditingController,
    this.onChange,
    this.label,
    this.height,
    this.bgColor,
    this.placeholder,
    this.direction = Axis.horizontal,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      crossAxisAlignment: direction == Axis.vertical
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        isNotNull(label)
            ? Padding(
                padding: direction == Axis.vertical
                    ? EdgeInsets.only(bottom: 8)
                    : EdgeInsets.only(right: 8),
                child: MText(label ?? ''),
              )
            : SizedBox(height: 0),
        direction == Axis.vertical
            ? inputContainer()
            : Flexible(child: inputContainer()),
      ],
    );
  }

  Widget inputContainer() {
    return Container(
      height: height ?? 48,
      width: Get.size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: CupertinoTextField(
        textAlign: textAlign,
        cursorHeight: 20.0,
        controller: textEditingController,
        padding: EdgeInsets.zero,
        placeholder: placeholder ?? '请输入',
        // prefix: Padding(
        //   padding: const EdgeInsets.only(right: 4),
        //   child: MText(
        //     '回复：阿西吧',
        //     color: MColors.grey9,
        //   ),
        // ),
        style: TextStyle(fontSize: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
        ),
        onChanged: onChange,
        //  TextField(
        //   controller: textEditingController,
        //   style: TextStyle(fontSize: 14),
        //   decoration: InputDecoration(
        //     hintText: '请输入',
        //     fillColor: Colors.white,
        //     border: InputBorder.none,
        //   ),
        //   onChanged: onChange,
      ),
    );
  }
}
