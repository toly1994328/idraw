import 'dart:math';

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
      ..moveTo(0, 0)
      ..relativeLineTo(40, 40)
      ..relativeLineTo(0, -40)
      ..close();
    // dashPainter.paint(canvas, path, Paint()..color=Colors.red..style=PaintingStyle.stroke..strokeWidth=1);

    Matrix4 m4 = Matrix4.translationValues(size.width/2, size.height/2, 0);
    Matrix4 center = Matrix4.translationValues(20, 20, 0);
    Matrix4 back = Matrix4.translationValues(-20, -20, 0);

    Matrix4 rotateM4 = Matrix4.rotationZ(10*pi/180);
    Matrix4 scaleM4 = Matrix4.diagonal3Values(2,2,1);
    drawHelp(m4, center, rotateM4, back, path, canvas);
    m4.multiply(center);
    m4.multiply(rotateM4);
    m4.multiply(scaleM4);
    m4.multiply(back);
    path = path.transform(m4.storage);
    canvas.drawPath(path, paint);


    canvas.drawRect(Offset.zero&size, Paint()..color=Color(0xff00fffc).withOpacity(0.1));
    canvas.drawCircle(Offset(size.width/2+20,size.height/2+20),2,Paint()..color=Colors.red);
  }

  void drawHelp(Matrix4 m4, Matrix4 center, Matrix4 rotateM4, Matrix4 back, Path path, Canvas canvas) {
    Matrix4 m = m4.multiplied(center);
    m.multiply(rotateM4);
    m.multiply(back);
    Path helpPath = path.transform(m.storage);
    dashPainter.paint(
        canvas,
        helpPath,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => true;
}
