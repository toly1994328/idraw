import 'dart:ui';

import 'package:flutter/material.dart';

import '../coordinate.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  final Offset p1 = Offset(80, -100);
  final Offset p2 = Offset(80, 50);
  final Offset p3 = Offset(160, 50);

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint();

    paint
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    _drawHelper(canvas);

    path.relativeCubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    canvas.drawPath(path, paint);

  }

  void _drawHelper(Canvas canvas) {
    canvas.drawPoints(
        PointMode.lines,
        [
          Offset.zero,
          p1,
          p2,
          p3,
          Offset.zero + p3,
          p1 + p3,
          p2 + p3,
          p3 + p3,
        ],
        Paint()
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round
          ..color = Colors.blue);
    canvas.drawPoints(
        PointMode.points,
        [
          Offset.zero,
          p1,
          p2,
          p3,
          Offset.zero + p3,
          p1 + p3,
          p2 + p3,
          p3 + p3,
        ],
        Paint()
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..color = Colors.blue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
