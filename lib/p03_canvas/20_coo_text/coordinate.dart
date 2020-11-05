import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:
@immutable
class Coordinate {
  final double step;
  final double strokeWidth;
  final Color axisColor;
  final Color gridColor;

  Coordinate(
      {this.step = 20,
      this.strokeWidth = .5,
      this.axisColor = Colors.blue,
      this.gridColor = Colors.grey});

  final Paint _gridPaint = Paint();

  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas, size);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = Colors.grey;
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _gridPaint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _gridPaint);
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPaint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _simpleDrawText(Canvas canvas, String str,
      {Offset offset = Offset.zero, Color color = Colors.black}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 11,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(color: color, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);

    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: 11.0 * str.length)),
        offset);
  }

  void _drawText(Canvas canvas, Size size) {
    // y > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _simpleDrawText(canvas, str,
            offset: Offset(8, -8), color: Colors.green);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    // x > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _simpleDrawText(canvas, "O", offset: Offset(8, 8), color: Colors.black);
        canvas.translate(step, 0);
        continue;
      }
      if (step < 30 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _simpleDrawText(canvas, str,
            offset: Offset(-8, 8), color: Colors.green);
      }
      canvas.translate(step, 0);
    }
    canvas.restore();

    // y < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _simpleDrawText(canvas, str,
            offset: Offset(8, -8), color: Colors.green);
      }

      canvas.translate(0, -step);
    }
    canvas.restore();

    // x < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _simpleDrawText(canvas, str,
            offset: Offset(-8, 8), color: Colors.green);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }
}
