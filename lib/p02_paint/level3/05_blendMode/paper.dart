import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
    drawBlendMode(canvas,BlendMode.lighten);
    canvas.translate(150, 0);
    drawBlendMode(canvas,BlendMode.hue);
    canvas.translate(150, 0);
    drawBlendMode(canvas,BlendMode.plus);
    canvas.translate(150, 0);
    drawBlendMode(canvas,BlendMode.hardLight);

  }
  void drawBlendMode(Canvas canvas,BlendMode mode) {
    var paint = Paint();
    canvas.drawCircle(Offset(100, 100), 50, paint..color = Color(0x88ff0000));

    canvas.drawCircle(
        Offset(140, 70),
        50,
        paint
          ..color = Color(0x8800ff00)
          ..blendMode = mode);

    canvas.drawCircle(
        Offset(140, 130),
        50,
        paint
          ..color = Color(0x880000ff)
          ..blendMode = mode);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
