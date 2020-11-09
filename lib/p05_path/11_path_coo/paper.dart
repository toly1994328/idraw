import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coordinate_pro.dart';

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
  final Coordinate coordinate = Coordinate(step: 25);


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;
}
