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
  Paint _helpPaint = Paint();

  double waveWidth = 80;
  double wrapHeight;

  double waveHeight = 40;

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    path.relativeQuadraticBezierTo( waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, waveHeight * 2, waveWidth, 0);

    canvas.drawPath(path, paint);
    _drawHelp(canvas);
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon,[Offset.zero, Offset(waveWidth / 2, -waveHeight * 2), Offset(waveWidth , 0)], _helpPaint..strokeWidth=1);
    canvas.drawPoints(PointMode.points, [Offset.zero, Offset(waveWidth / 2, -waveHeight * 2), Offset(waveWidth , 0)],
        _helpPaint..strokeWidth = 8);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
