import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../coordinate_pro.dart';

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

  Offset p1 = Offset(100, 100);
  Offset p2 = Offset(120, -60);
  Paint _helpPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
    _drawHelp(canvas);
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines,[Offset.zero, p1, p1,p2], _helpPaint..strokeWidth=1);
    canvas.drawPoints(PointMode.points, [Offset.zero, p1, p1, p2],
        _helpPaint..strokeWidth = 8);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
