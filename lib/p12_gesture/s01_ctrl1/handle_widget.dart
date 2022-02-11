import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/3
/// contact me by email 1981462002@qq.com
/// 说明:

class HandleWidget extends StatefulWidget {
  final double size;
  final double handleRadius;

  HandleWidget({Key? key, this.size = 160.0, this.handleRadius = 20.0})
      : super(key: key);

  @override
  _HandleWidgetState createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _HandlePainter(handleR: widget.handleRadius));
  }
}

class _HandlePainter extends CustomPainter {
  var _paint = Paint();

  var handleR;

  _HandlePainter({this.handleR}) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    final bgR = size.width / 2 - handleR;

    canvas.translate(size.width / 2, size.height / 2);
    _paint.color = _paint.color.withAlpha(100);
    canvas.drawCircle(Offset(0, 0), bgR, _paint);
    _paint.color = _paint.color.withAlpha(150);
    canvas.drawCircle(Offset(0, 0), handleR, _paint);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) =>
      oldDelegate.handleR != handleR;
}
