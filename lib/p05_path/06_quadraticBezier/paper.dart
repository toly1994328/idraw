import 'dart:math';
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

  final Offset p1 = Offset(100, -100);
  final Offset p2 = Offset(160, 50);


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    _drawHelper(canvas);

    path.relativeQuadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);

  }

  void _drawHelper(Canvas canvas) {
    canvas.drawPoints(
        PointMode.polygon,
        [
          Offset.zero,
          p1,
          p2,
          p1.translate(160, 50),
          p2.translate(160, 50),
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
          p1.translate(160, 50),
          p2.translate(160, 50),
        ],
        Paint()
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..color = Colors.blue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
