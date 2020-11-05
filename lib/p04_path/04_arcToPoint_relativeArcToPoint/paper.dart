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
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.lineTo(80, -40);

    //绘制中间
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: false,
      )
      ..close();
    canvas.drawPath(path, paint);

    //绘制左侧
    path.reset();
    canvas.translate(-150, 0);
    path.lineTo(80, -40);
    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);

    //绘制右侧
    path.reset();
    canvas.translate(150 + 150.0, 0);
    path.lineTo(80, -40);
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: true,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
