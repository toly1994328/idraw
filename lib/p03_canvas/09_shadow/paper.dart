import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

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
    // coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..isAntiAlias = true;
    double relativeX = 100;
    double angle = 0;
    double width = 10;
    double height = 10;
    double center =  relativeX + width / 2;
    if(angle == 0) {
      center = relativeX + width/4;
    } else if (angle == 2) {
      center = relativeX + width/4*3;
    }

    Path trianglePath = Path()
      ..addPolygon([Offset(relativeX, height), Offset(relativeX + width, height), Offset(center, 0),], false)..close();

    Path rectanglePath = Path()
      ..addRRect(RRect.fromLTRBR(0, 10, 160, 100, Radius.circular(8)))..close();


    canvas.drawShadow(Path.combine(PathOperation.xor, trianglePath, rectanglePath), Colors.black, 3, false);
    canvas.drawPath(Path.combine(PathOperation.xor, trianglePath, rectanglePath), paint..color = Colors.white);
    paint.maskFilter = MaskFilter.blur(BlurStyle.inner, 20);
    canvas.drawPath(Path.combine(PathOperation.xor, trianglePath, rectanglePath), paint..color=Color(0xffBEC4C0));

  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
