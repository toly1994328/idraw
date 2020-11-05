
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
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

   _drawTextLeft(canvas);
   // _drawTextCenter(canvas);
   // _drawTextTextAlignRight(canvas);
//     _drawTextPaint(canvas);
  }

  void _drawTextLeft(Canvas canvas) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("Flutter Unit");

    canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: 300)),
        Offset(0, -100));
    canvas.drawRect(Rect.fromLTRB(0, 0 - 100.0, 300, 40 - 100.0),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextCenter(Canvas canvas) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("Flutter Unit");

    canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: 300)),
        Offset(0, 0));

    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextTextAlignRight(Canvas canvas) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.right,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("Flutter Unit");

    canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: 300)),
        Offset(0, 100));

    canvas.drawRect(Rect.fromLTRB(0, 0 + 100.0, 300, 40 + 100.0),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaint(Canvas canvas) {
    TextPainter(
        text: TextSpan(
            text: '张风捷特烈 Flutter Unit',
            style: TextStyle(fontSize: 40, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: 300)
      ..paint(canvas, Offset(0, 0));

    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;
}
