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
 late Paint _paint;
 late Path _path;

  PaperPainter() {
    _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    _path = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawLine(Offset(0, 0), Offset(100, 100), _paint);

    _path.moveTo(100, 100);
    _path.lineTo(200, 0);
    canvas.drawPath(_path, _paint..color=Colors.red);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
