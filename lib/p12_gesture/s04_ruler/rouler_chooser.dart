import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020/11/3
/// contact me by email 1981462002@qq.com
/// 说明:

class RulerChooser extends StatefulWidget {
  final Size size;
  final void Function(double) onChanged;
  final int min;
  final int max;

  RulerChooser(
      {Key? key,
      required this.onChanged,
      this.max = 200,
      this.min = 100,
      this.size = const Size(240.0, 60)})
      : super(key: key);

  @override
  _RulerChooserState createState() => _RulerChooserState();
}

class _RulerChooserState extends State<RulerChooser> {
  ValueNotifier<double> _dx = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _parser,
      child: CustomPaint(
          size: widget.size,
          painter: _HandlePainter(dx: _dx, max: widget.max, min: widget.min)),
    );
  }

  double dx = 0;

  void _parser(DragUpdateDetails details) {
    dx += details.delta.dx;

    if (dx > 0) {
      dx = 0.0;
    }
    var limitMax = -(widget.max - widget.min) * (_kSpacer + _kStrokeWidth);
    if (dx < limitMax) {
      dx = limitMax;
    }
    _dx.value = dx;

    if (widget.onChanged != null) {
      widget.onChanged(details.delta.dx / (_kSpacer + _kStrokeWidth));
    }
  }
}

const double _kHeightLevel1 = 20; // 短线长
const double _kHeightLevel2 = 25; // 5 线长
const double _kHeightLevel3 = 30; //10 线长
const double _kPrefixOffSet = 5; // 左侧偏移
const double _kVerticalOffSet = 12; // 线顶部偏移
const double _kStrokeWidth = 2; // 刻度宽
const double _kSpacer = 4; // 刻度间隙
const List<Color> _kRulerColors = [
  // 渐变色
  Color(0xFF1426FB),
  Color(0xFF6080FB),
  Color(0xFFBEE0FB),
];
const List<double> _kRulerColorStops = [0.0, 0.2, 0.8];

class _HandlePainter extends CustomPainter {
  var _paint = Paint();
  Paint _pointPaint = Paint();

  final ValueNotifier<double> dx;

  final int max;
  final int min;

  _HandlePainter({required this.dx,required this.max,required this.min}) : super(repaint: dx) {
    _paint
      ..strokeWidth = _kStrokeWidth
          ..shader = ui.Gradient.radial(
          Offset(0, 0), 25, _kRulerColors, _kRulerColorStops, TileMode.mirror);
    _pointPaint
      ..color = Colors.purple
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    drawArrow(canvas);
    canvas.translate(dx.value, 0);
    drawRuler(canvas);
  }

  // 绘制刻度
  void drawRuler(Canvas canvas) {
    double y = _kHeightLevel1;
    for (int i = min; i < max + 5; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        y = _kHeightLevel2;
      } else if (i % 10 == 0) {
        y = _kHeightLevel3;
        _simpleDrawText(canvas, i.toString(),
            offset: Offset(-3, _kHeightLevel3 + 5));
      } else {
        y = _kHeightLevel1;
      }
      canvas.drawLine(Offset.zero, Offset(0, y), _paint);
      canvas.translate(_kStrokeWidth + _kSpacer, 0);
    }
  }

  // 绘制三角形尖角
  void drawArrow(Canvas canvas) {
    var path = Path()
      ..moveTo(_kStrokeWidth / 2 + _kPrefixOffSet, 3)
      ..relativeLineTo(-3, 0)
      ..relativeLineTo(3, _kPrefixOffSet)
      ..relativeLineTo(3, -_kPrefixOffSet)
      ..close();
    canvas.drawPath(path, _pointPaint);
    canvas.translate(_kStrokeWidth / 2 + _kPrefixOffSet, _kVerticalOffSet);
  }

  void _simpleDrawText(Canvas canvas, String str,
      {Offset offset = Offset.zero}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle())
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);
    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: 11.0 * str.length)),
        offset);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) =>
      oldDelegate.dx != dx || oldDelegate.min != min || oldDelegate.max != max;
}
