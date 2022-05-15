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
      ..lineTo(40, 40)
      ..relativeLineTo(0, -40)
      ..close();
    // Matrix4 m4 = Matrix4.translationValues(size.width/2, size.height/2, 0);
    // path = path.transform(m4.storage);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => true;
}
