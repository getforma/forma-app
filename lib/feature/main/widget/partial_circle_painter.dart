import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:forma_app/styles/app_colors.dart';

class PartialCirclePainter extends CustomPainter {
  final Color color;
  final double degree;
  final double width;

  PartialCirclePainter({
    this.color = AppColors.pureWhite,
    this.width = 0,
    this.degree = 360,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radians = degree * 2 * math.pi / 360;
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

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
