import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../coordinate.dart';

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

  late Paint _paint;

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

    // _drawTextWithParagraph(canvas,TextAlign.left);
    // _drawTextWithParagraph(canvas,TextAlign.center);
    // _drawTextWithParagraph(canvas,TextAlign.right);

    // _drawWithTextPaint(canvas);
    // _drawTextPaintShowSize(canvas);
    _drawTextPaintWithPaint(canvas);
  }

  void _drawTextWithParagraph(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));
    builder.pushStyle(
      ui.TextStyle(
          color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
    );
    builder.addText("Flutter Unit");
    ui.Paragraph paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset(0, 0));

    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawWithTextPaint(Canvas canvas) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit',
            style: TextStyle(fontSize: 40, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    // 进行布局
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);
  }

  void _drawTextPaintShowSize(Canvas canvas) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit',
            style: TextStyle(
                // foreground: Paint()..style=PaintingStyle.stroke,
                fontSize: 40,
                color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout(); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaintWithPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit by 张风捷特烈',
            style: TextStyle(
                foreground: textPaint, fontSize: 40)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout(maxWidth: 280); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;
}
