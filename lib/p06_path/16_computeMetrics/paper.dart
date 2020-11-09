import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatelessWidget{
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

    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      print(
          "---length:-${pm.length}----contourIndex:-${pm.contourIndex}----contourIndex:-${pm.isClosed}----");

      Tangent tangent = pm.getTangentForOffset(pm.length * 0.5);
      print(
          "---position:-${tangent.position}----angle:-${tangent.angle}----vector:-${tangent.vector}----");

      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
    });

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
