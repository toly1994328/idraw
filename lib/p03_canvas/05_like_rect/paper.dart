import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'coordinate.dart';

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
  final Coordinate coordinate = Coordinate();

  Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);

    canvas.translate(size.width / 2, size.height / 2);

    _drawDRRect(canvas);

    canvas.translate(-240, 0);
    _drawRect(canvas);

    canvas.translate(480, 0);
    _drawRRect(canvas);
  }

  void _drawRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.矩形中心构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, _paint);
    //【2】.矩形左上右下构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color = Colors.red);
    //【3】. 矩形左上宽高构造
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color = Colors.orange);
    //【4】. 矩形内切圆构造
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color = Colors.green);
    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, _paint..color = Colors.purple);
  }

  void _drawRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.圆角矩形fromRectXY构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), _paint);

    //【2】.圆角矩形fromLTRBXY构造
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        _paint..color = Colors.red);

    //【3】. 圆角矩形fromLTRBR构造
    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
        _paint..color = Colors.orange);

    //【4】. 圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: Radius.elliptical(10, 10)),
        _paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomLeft: Radius.elliptical(10, 10)),
        _paint..color = Colors.purple);
  }

  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    Rect outRect =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    Rect inRect =
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);

    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20),
        RRect.fromRectXY(inRect, 20, 20), _paint);

    Rect outRect2 =
        Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
    Rect inRect2 = Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
    canvas.drawDRRect(RRect.fromRectXY(outRect2, 15, 15),
        RRect.fromRectXY(inRect2, 10, 10), _paint..color = Colors.green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
