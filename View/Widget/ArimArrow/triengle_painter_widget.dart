import 'package:flutter/material.dart';

import 'anim_arrow.dart';



class Trienge extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final Direction direction;
  const Trienge(
      {super.key,
      this.color = Colors.blue,
      this.strokeWidth = 20,
      this.direction = Direction.reight});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: TrianglePainter(
      direction: direction,
      strokeColor: color,
      strokeWidth: 40,
      paintingStyle: PaintingStyle.fill,
    ));
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final Direction direction;

  TrianglePainter(
      {required this.direction,
      this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    switch (direction) {
      case Direction.reight:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, y / 2)
          ..lineTo(0, y)
          ..lineTo(0, 0);
      case Direction.left:
        return Path()
          ..moveTo(x, 0)
          ..lineTo(0, y / 2)
          ..lineTo(x, y)
          ..lineTo(x, 0);
      case Direction.up:
        return Path()
          ..moveTo(0, y)
          ..lineTo(x / 2, 0)
          ..lineTo(x, y)
          ..lineTo(0, y);
      default:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, 0)
          ..lineTo(x/2, y)
          ..lineTo(0, 0);
    }
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
