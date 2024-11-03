import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PartialCirclePainter extends CustomPainter {
  final Color color;
  final Color colorInactive;
  final double degree;
  final double width;

  PartialCirclePainter({
    this.color = AppColors.pureWhite,
    this.colorInactive = AppColors.blueGrey100,
    this.width = 0,
    this.degree = 360,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colorInactive
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(size.height / 2, size.width / 2),
      size.height / 2,
      paint,
    );

    final radians = degree * 2 * math.pi / 360;
    paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      -math.pi / 2,
      radians,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(PartialCirclePainter oldDelegate) =>
      oldDelegate.degree != degree;
}
