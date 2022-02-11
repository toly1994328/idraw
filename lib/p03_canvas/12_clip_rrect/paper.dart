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

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    // canvas.save();
    var rect = Rect.fromCenter(center: Offset.zero,width: 200,height: 100);
    canvas.clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(30)));
    canvas.drawColor(Colors.red, BlendMode.darken);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
