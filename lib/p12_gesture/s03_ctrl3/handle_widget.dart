import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/3
/// contact me by email 1981462002@qq.com
/// 说明:

class HandleWidget extends StatefulWidget {
  final double size;
  final double handleRadius;
  final void Function(double rotate, double distance) onMove;

  HandleWidget(
      {Key key,
      this.size = 160,
      this.handleRadius = 20.0,
      @required this.onMove})
      : super(key: key);

  @override
  _HandleWidgetState createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
          onPanEnd: reset,
          onPanUpdate: parser,
          child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _HandlePainter(
                  color: Colors.green,
                  handleR: widget.handleRadius,
                  offset: _offset))),
    );
  }

  reset(DragEndDetails details) {
    _offset.value = Offset.zero;
    if (widget.onMove != null) {
      widget.onMove(0, 0);
    }
  }

  parser(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;

    dx = offset.dx - widget.size / 2;
    dy = offset.dy - widget.size / 2;
    var rad = atan2(dx, dy);
    if (dx < 0) {
      rad += 2 * pi;
    }
    var bgR = widget.size / 2 - widget.handleRadius;
    var thta = rad - pi / 2; //旋转坐标系90度
    var d = sqrt(dx * dx + dy * dy);
    if (d > bgR) {
      dx = bgR * cos(thta);
      dy = -bgR * sin(thta);
    }
    if (widget.onMove != null) {
      widget.onMove(thta, d);
    }

    _offset.value = Offset(dx, dy);
  }
}

class _HandlePainter extends CustomPainter {
  var _paint = Paint();
  final ValueNotifier<Offset> offset;
  final Color color;

  var handleR;

  _HandlePainter({this.handleR, this.offset, this.color = Colors.blue})
      : super(repaint: offset);


  @override
  void paint(Canvas canvas, Size size) {

    canvas.clipRect(Offset.zero & size);

    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);

    _paint.style = PaintingStyle.fill;
    _paint.color = color.withAlpha(100);

    canvas.drawCircle(Offset(0, 0), bgR, _paint);

    _paint.color = color.withAlpha(150);

    canvas.drawCircle(
        Offset(offset.value.dx, offset.value.dy), handleR, _paint);

    _paint.color = color;
    _paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, offset.value, _paint);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) =>
      oldDelegate.offset != offset ||
      oldDelegate.color != color ||
      oldDelegate.handleR != handleR;
}
