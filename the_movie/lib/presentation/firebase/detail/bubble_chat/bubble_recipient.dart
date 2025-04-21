import 'package:flutter/material.dart';

class GreyBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0009045731, size.height * 0.9840118);
    path_0.cubicTo(
        size.width * 0.02090458,
        size.height * 0.9996980,
        size.width * 0.04064808,
        size.height * 0.9435529,
        size.width * 0.04705846,
        size.height * 0.9076059);
    path_0.cubicTo(
        size.width * 0.04045115,
        size.height * 0.8272824,
        size.width * 0.08124269,
        size.height * 0.6321941,
        size.width * 0.05431962,
        size.height * 0.6321863);
    path_0.cubicTo(
        size.width * 0.04809423,
        size.height * 0.6321863,
        size.width * 0.04277692,
        size.height * 0.5490471,
        size.width * 0.02013535,
        size.height * 0.6114627);
    path_0.cubicTo(
        size.width * 0.02005377,
        size.height * 0.6366941,
        size.width * 0.02013535,
        size.height * 0.7240353,
        size.width * 0.02013535,
        size.height * 0.7389059);
    path_0.cubicTo(
        size.width * 0.02013535,
        size.height * 0.9447882,
        size.width * -0.002941581,
        size.height * 0.9721824,
        size.width * 0.0009045731,
        size.height * 0.9840118);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff262628).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xff262628).withOpacity(1.0);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          size.width * 0.01961542,
          0,
          size.width * 0.9803846,
          size.height * 0.9803922,
        ),
        bottomRight: Radius.circular(size.width * 0.06923077),
        bottomLeft: Radius.circular(size.width * 0.06923077),
        topLeft: Radius.circular(size.width * 0.06923077),
        topRight: Radius.circular(size.width * 0.06923077),
      ),
      paint_1_fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
