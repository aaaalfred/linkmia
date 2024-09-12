import 'package:flutter/material.dart';
import 'dart:math';

class SquaresPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[900]!
      ..style = PaintingStyle.fill;

    final random = Random();
    for (int i = 0; i < 10; i++) {
      final square = Rect.fromLTWH(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
        random.nextDouble() * 20 + 5,
        random.nextDouble() * 20 + 5,
      );
      canvas.drawRect(square, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}