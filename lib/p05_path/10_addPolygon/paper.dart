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


  final Coordinate coordinate;
  PaperPainter({this.coordinate});

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var p0 = Offset(100, 100);
    path
      ..lineTo(100, 100)
      ..addPolygon([
        p0,
        p0.translate(20, -20),
        p0.translate(40, -20),
        p0.translate(60, 0),
        p0.translate(60, 20),
        p0.translate(40, 40),
        p0.translate(20, 40),
        p0.translate(0, 20),
      ], true)
      ..addPath(
          Path()..relativeQuadraticBezierTo(125, -100, 260, 0), Offset.zero)
      ..lineTo(160, 100);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
