import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

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
  @override
  void paint(Canvas canvas, Size size) {
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
      ..strokeWidth = 100;

    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos, TileMode.clamp);
    canvas.drawLine(
      Offset(0, 100),
      Offset(200, 100),
      paint,
    );

    paint.shader = ui.Gradient.linear(Offset(0 + 220.0, 0),
        Offset(100 + 220.0, 0), colors, pos, TileMode.repeated);
    canvas.drawLine(
      Offset(0 + 220.0, 100),
      Offset(200 + 220.0, 100),
      paint,
    );

    paint.shader = ui.Gradient.linear(Offset(0 + 220.0 * 2, 0),
        Offset(100 + 220.0 * 2, 0), colors, pos, TileMode.mirror);
    canvas.drawLine(
      Offset(0 + 220.0 * 2, 100),
      Offset(200 + 220.0 * 2, 100),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
