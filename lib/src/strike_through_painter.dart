import 'package:flutter/material.dart';

/// A custom painter for drawing the strikethrough line.
class StrikethroughPainter extends CustomPainter {
  final Color color;
  final double width;
  final List<double> dashArray;

  /// Creates a new [_StrikethroughPainter] instance.
  ///
  /// The [color] and [width] arguments are required.
  ///
  /// The [dashArray] argument has a default value.
  StrikethroughPainter(
      {required this.color, required this.width, this.dashArray = const []});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    if (dashArray.isNotEmpty) {
      final path = Path();
      double dashOffset = 0;
      bool draw = true;

      while (dashOffset < size.width) {
        double segmentLength = dashArray[dashOffset.toInt() % dashArray.length];
        if (draw) {
          path.moveTo(dashOffset, size.height / 2);
          path.lineTo(dashOffset + segmentLength, size.height / 2);
        }
        dashOffset += segmentLength;
        draw = !draw;
      }
      canvas.drawPath(path, paint);
    } else {
      canvas.drawLine(Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant StrikethroughPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.width != width ||
        oldDelegate.dashArray != dashArray;
  }
}
