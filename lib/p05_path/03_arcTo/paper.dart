import 'dart:math';

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
      child: CustomPaint( // 使用CustomPaint
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
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    var rect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 100);

    path.lineTo(30, 30);
    path..arcTo(rect, 0, pi * 1.5, true);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(200, 0);
    path.lineTo(30, 30);
    path..arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
