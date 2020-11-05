import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  void initState() {
    //横屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    //全屏显示
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
        painter: PaperPainter(),
    );
  }
}

class PaperPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    drawShaderRadial(canvas);
  }

  void drawShaderRadial(Canvas canvas) {
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
    Paint paint =  Paint();
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    paint.shader = ui.Gradient.radial(
        Offset(80 + 150.0 * 0, 80), 25, colors, pos, TileMode.clamp);
    canvas.drawCircle(
      Offset(80 + 150.0 * 0, 80),
      50,
      paint,
    );

    paint.shader = ui.Gradient.radial(
        Offset(80 + 150.0 * 1, 80), 25, colors, pos, TileMode.repeated);
    canvas.drawCircle(
      Offset(80 + 150.0 * 1, 80),
      50,
      paint,
    );

    paint.shader = ui.Gradient.radial(
        Offset(80 + 150.0 * 2, 80), 25, colors, pos, TileMode.mirror);
    canvas.drawCircle(
      Offset(80 + 150.0 * 2, 80),
      50,
      paint,
    );
    paint.shader = ui.Gradient.radial(Offset(80 + 150.0 * 3, 80), 25, colors,
        pos, TileMode.mirror, null, Offset(80 + 150.0 * 3 - 5, 80 - 5.0), 10);
    canvas.drawCircle(
      Offset(80 + 150.0 * 3, 80),
      50,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
