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
    // drawStrokeCap(canvas);
    // drawStrokeJoin(canvas);
    drawStrokeMiterLimit(canvas);
  }

  // 测试 strokeCap 属性
  void drawStrokeCap(Canvas canvas) {
    Paint paint =  Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(
        Offset(50, 50), Offset(50, 150), paint..strokeCap = StrokeCap.butt);
    canvas.drawLine(Offset(50 + 50.0, 50), Offset(50 + 50.0, 150),
        paint..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(50 + 50.0 * 2, 50), Offset(50 + 50.0 * 2, 150),
        paint..strokeCap = StrokeCap.square);

    //测试线
    canvas.drawLine(
        Offset(0, 50),
        Offset(1600, 50),
        paint
          ..strokeWidth = 1
          ..color = Colors.cyanAccent);
    canvas.drawLine(
        Offset(0, 150),
        Offset(1600, 150),
        paint
          ..strokeWidth = 1
          ..color = Colors.cyanAccent);
  }

  // 测试 strokeJoin 属性
  void drawStrokeJoin(Canvas canvas) {
    Paint paint =  Paint();
    Path path =  Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(50 + 150.0, 50);
    path.lineTo(50 + 150.0, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(50 + 150.0 * 2, 50);
    path.lineTo(50 + 150.0 * 2, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  // 测试 strokeMiterLimit 属性
  void drawStrokeMiterLimit(Canvas canvas) {
    Paint paint =  Paint();
    Path path =  Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50);
      path.lineTo(50 + 150.0 * i, 150);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 2);
    }

    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50 + 150.0);
      path.lineTo(50 + 150.0 * i, 150 + 150.0);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(
          path,
          paint
            ..strokeMiterLimit = 3);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
