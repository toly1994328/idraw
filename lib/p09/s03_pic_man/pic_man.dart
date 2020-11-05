import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/2
/// contact me by email 1981462002@qq.com
/// 说明: 

class PicMan extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    canvas.translate(size.width/2, size.height/2);
    _drawArcDetail(canvas);
  }

  void _drawArcDetail(Canvas canvas) {
    var rect = Rect.fromCenter(center: Offset(0, 0), height: 100, width: 100);
    Paint _paint = Paint();


    var a = pi / 8;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color=Colors.yellowAccent);
    canvas.translate(40, 0);

    canvas.translate(40, 0);
    canvas.drawCircle(Offset(0, 0), 6, _paint);
    canvas.translate(25, 0);
    canvas.drawCircle(Offset(0, 0), 6, _paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
