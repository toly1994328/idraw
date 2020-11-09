
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

  final Coordinate coordinate=Coordinate();

  final Offset p1 = Offset(80, -100);
  final Offset p2 = Offset(160, 0);


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);

    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    //抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    _drawHelper(canvas);
    canvas.drawPath(path, paint);

    //椭圆线
    path.reset();
    canvas.translate(-180, 0);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.drawPath(path, paint);
    _drawHelper(canvas);

    //双曲线
    path.reset();
    canvas.translate(180+180.0, 0);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, paint);
    _drawHelper(canvas);
  }

  void _drawHelper(Canvas canvas) {
    canvas.drawPoints(
        PointMode.points,
        [
          p1,
          p2,
        ],
        Paint()
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..color = Colors.blue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
