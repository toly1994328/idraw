import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // drawIsAntiAliasColor(canvas);
    drawStyleStrokeWidth(canvas);
  }

  // 测试 isAntiAlias 和 color属性
  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        Offset(180, 180),
        170,
        paint
          ..color = Colors.blue
          ..strokeWidth = 5);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        170,
        paint
          ..isAntiAlias = false
          ..color = Colors.red);
  }

  // 测试 style 和 strokeWidth 属性
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red;
    canvas.drawCircle(
        Offset(180, 180),
        150,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 50);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        150,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
    //测试线
    canvas.drawLine(
        Offset(0, 180 - 150.0),
        Offset(1600, 180 - 150.0),
        paint
          ..strokeWidth = 1
          ..color = Colors.blueAccent);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
