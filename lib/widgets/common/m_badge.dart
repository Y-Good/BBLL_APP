import 'dart:math';

import 'package:flutter/material.dart';

class MBadge extends StatelessWidget {
  MBadge({
    this.child,
    this.value,
    this.style,
    this.hidden = true,
    this.dot = false,
    this.offset,
  }) : assert(value is int || value is String || value == null,
            "value只能是num或者String类型");

  final value;

  final TextStyle? style;

  final bool hidden;

  ///原点
  final bool dot;

  final Widget? child;

  /// 在默认值上偏移量
  final Offset? offset;

  String get valueString {
    if (value is String) return value;
    if (value is int) {
      return (value ?? 0) > 99 ? '99+' : value.toString();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (hidden || (value == null && !dot)) return child ?? const SizedBox();
    if (dot) {
      return CustomPaint(
        foregroundPainter: _DotPainter(offset),
        child: child,
      );
    }
    String space = valueString.length == 1 ? '\t' : '\t\t';
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "$space$valueString$space",
        style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4)
            .merge(style),
      ),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
      maxLines: 1,
    )..layout();
    return CustomPaint(
      foregroundPainter: _OvalPainter(textPainter, offset),
      child: child,
    );
  }
}

class _OvalPainter extends CustomPainter {
  _OvalPainter(this.text, this.offset);

  final TextPainter text;

  /// 偏移量
  final Offset? offset;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red;
    double width = max(text.width, text.height);
    double x = (offset?.dx ?? 0) + size.width - width * 0.5;
    double y = offset?.dy ?? 0;
    double dx = (width - text.width).abs() * 0.5 + x;
    double dy = y;
    canvas.drawRRect(
        RRect.fromLTRBR(x, y, x + width, y + text.height,
            Radius.circular(text.height * 0.5)),
        paint);
    text.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _DotPainter extends CustomPainter {
  _DotPainter(this.offset);
  final Offset? offset;

  @override
  void paint(Canvas canvas, Size size) {
    var point = Paint();
    point.color = Colors.red;
    double dx = (offset?.dx ?? 0) + size.width;
    double dy = (offset?.dy ?? 0) + size.height * 0.125;
    canvas.drawCircle(Offset(dx, dy), 3.5, point);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
