import 'package:flutter/material.dart';

class BlueBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff468CF7).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                0, 0, size.width * 0.9766284, size.height * 0.9803922),
            bottomRight: Radius.circular(size.width * 0.06896552),
            bottomLeft: Radius.circular(size.width * 0.06896552),
            topLeft: Radius.circular(size.width * 0.06896552),
            topRight: Radius.circular(size.width * 0.06896552)),
        paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9958851, size.height * 0.9840118);
    path_1.cubicTo(
        size.width * 0.9759617,
        size.height * 0.9996980,
        size.width * 0.9562950,
        size.height * 0.9435529,
        size.width * 0.9499080,
        size.height * 0.9076059);
    path_1.cubicTo(
        size.width * 0.9564904,
        size.height * 0.8272824,
        size.width * 0.9158544,
        size.height * 0.6321941,
        size.width * 0.9426743,
        size.height * 0.6321863);
    path_1.cubicTo(
        size.width * 0.9488774,
        size.height * 0.6321863,
        size.width * 0.9541724,
        size.height * 0.5490471,
        size.width * 0.9767280,
        size.height * 0.6114627);
    path_1.cubicTo(
        size.width * 0.9768084,
        size.height * 0.6366941,
        size.width * 0.9767280,
        size.height * 0.7240353,
        size.width * 0.9767280,
        size.height * 0.7389059);
    path_1.cubicTo(
        size.width * 0.9767280,
        size.height * 0.9447882,
        size.width * 0.9997165,
        size.height * 0.9721824,
        size.width * 0.9958851,
        size.height * 0.9840118);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xff468CF7).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
