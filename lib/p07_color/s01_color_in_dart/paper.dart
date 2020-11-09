import 'dart:ui';
import 'package:flutter/material.dart';

import '../coordinate_pro.dart';

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
  static const double step = 20; // 方格变长
  final Coordinate coordinate = Coordinate(step: step);

  // 颜色列表 256 个元素
  final Color colors = Color(0xffBBE9F7).withRed(0);
  // final Color colors = Color(0xff00E9F9);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    List<String> values = colors.value.toRadixString(2).split('').toList();

    // 遍历列表 绘制矩形色块
    canvas.translate(-step * 4.0, -step * 2.0);
    values.asMap().forEach((i, v) {
      int line = (i % 8); // 行
      int row = i ~/ 8; // 列
      var topLeft = Offset(step * line, step * row);
      var rect = Rect.fromPoints(topLeft, topLeft.translate(step, step));
      canvas.drawRect(
          rect, paint..color = v == '0' ? Colors.red : Colors.black);
    });

    canvas.restore();
    coordinate.paint(canvas, size); //绘制坐标系
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
