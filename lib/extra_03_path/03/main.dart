import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

import '../coordinate_pro.dart';

void main() {
  runApp(CustomPaint(
    painter: PathPainter(),
  ));
}


class PathPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    Paint paint = Paint()..style = PaintingStyle.stroke;
    Path path = Path()
      ..moveTo(size.width/2, size.height/2,)
      ..relativeLineTo(40, 40)
      ..relativeLineTo(0, -40)
      ..close();
    print(path.contains(Offset(30,10)));

    canvas.drawPath(path, paint);

    canvas.drawRect(Offset.zero&size, Paint()..color=Color(0xff00fffc).withOpacity(0.15));
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => true;
}
