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
  double wrapHeight =100;
  double waveHeight = 40;

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;


    canvas.save();
    canvas.translate(-2*waveWidth, 0);
    path.moveTo(0, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, -waveHeight*2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, waveHeight*2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, -waveHeight*2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, waveHeight*2, waveWidth, 0);
    // path.relativeLineTo(0, wrapHeight);
    // path.relativeLineTo(-waveWidth*2 * 2.0, 0);
    path.close();
    canvas.drawPath(path, paint..style=PaintingStyle.fill);
    canvas.restore();

    _drawHelp(canvas);

  }

  void _drawHelp(Canvas canvas) {
    _helpPaint
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
      canvas.drawRect(Rect.fromPoints(Offset(0,-100), Offset(160,100)), _helpPaint..strokeWidth=2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
