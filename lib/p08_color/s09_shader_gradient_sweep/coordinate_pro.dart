import 'dart:math';

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
  final Path _gridPath = Path();

  void paint(Canvas canvas, Size size) {

    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    // Paint paint = Paint();
    // paint
    //   ..style = PaintingStyle.fill
    //   ..color = Colors.blue;

    _gridPaint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.mirror, pi / 2, pi);

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGridLine(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas, size);
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

  void _drawGridLine(Canvas canvas, Size size) {
    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = Colors.grey;

    for (int i = 0; i < size.width / 2 / step; i++) {
      _gridPath.moveTo(step * i, -size.height / 2 );
      _gridPath.relativeLineTo(0, size.height);

      _gridPath.moveTo(-step * i, -size.height / 2 );
      _gridPath.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      _gridPath.moveTo(-size.width / 2,step * i );
      _gridPath.relativeLineTo(size.width,0 );

      _gridPath.moveTo(-size.width / 2,-step * i,  );
      _gridPath.relativeLineTo(size.width,0 );
    }

    canvas.drawPath(_gridPath, _gridPaint);
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
