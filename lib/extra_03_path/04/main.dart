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
  DashPainter dashPainter = DashPainter();


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    Paint paint = Paint()..style = PaintingStyle.stroke;
    Path path = Path()
      // ..moveTo(size.width/2, size.height/2,)
      ..relativeLineTo(40, 40)
      ..relativeLineTo(0, -40)
      ..close();
    // Matrix4 m4 = Matrix4.translationValues(size.width/2, size.height/2, 0);
    // path = path.transform(m4.storage);
    dashPainter.paint(canvas, path, Paint()..color=Colors.red..style=PaintingStyle.stroke..strokeWidth=1);
    canvas.translate(size.width/2, size.height/2,);
    // print(path.contains(Offset(30+size.width/2,10+size.height/2)));
    print(path.contains(Offset(30,10)));

    canvas.drawPath(path, paint);

    canvas.drawRect(Offset.zero&size, Paint()..color=Color(0xff00fffc).withOpacity(0.15));
    canvas.drawCircle(Offset(30,10),2,Paint()..color=Colors.red);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => true;
}
