import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();
  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-100, 0);

    drawShaderLinear(canvas);
  }

  void drawShaderLinear(Canvas canvas) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    Paint paint = Paint();

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 50;

    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.clamp);
    canvas.drawLine(
      Offset(0, 0),
      Offset(200, 0),
      paint,
    );

    canvas.translate(240, 0);
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.repeated);
    canvas.drawLine(
      Offset(0, 0),
      Offset(200, 0),
      paint,
    );

    canvas.translate(-240*2.0, 0);
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.mirror);
    canvas.drawLine(
      Offset(0, 0),
      Offset(200, 0),
      paint,
    );

    canvas.translate(0, 100);
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.mirror,Matrix4.rotationZ(pi/6).storage);
    canvas.drawLine(
      Offset(0, 0),
      Offset(200, 0),
      paint,
    );

    canvas.translate(240, 0);
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.mirror,Matrix4.translationValues(20, 0, 0).storage);
    canvas.drawLine(
      Offset(0, 0),
      Offset(200, 0),
      paint,
    );

    canvas.translate(240, 0);
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.mirror,Matrix4.skewX(-pi/6).storage);
    canvas.drawLine(
      Offset(0, 0),
      Offset(200, 0),
      paint,
    );
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
