import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    canvas.drawPath(path, paint);

    print(path.contains(Offset(20, 20)));
    print(path.contains(Offset(0, 20)));

    Rect bounds = path.getBounds();
    canvas.drawRect(
        bounds,
        Paint()
          ..color = Colors.orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
