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
    drawInvertColors(canvas);
  }
  void drawInvertColors(Canvas canvas) {
    var paint = Paint();
    paint..color = Color(0xff009A44);
    canvas.drawCircle(Offset(100, 100), 50, paint..invertColors = false);
    canvas.drawCircle(Offset(100+120.0, 100), 50, paint..invertColors = true);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
