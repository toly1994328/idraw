import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/2
/// contact me by email 1981462002@qq.com
/// 说明:
///

class PicMan extends StatefulWidget {
  final Color color;

  PicMan({Key key, this.color = Colors.lightBlue}) : super(key: key);

  @override
  _PicManState createState() => _PicManState();
}

class _PicManState extends State<PicMan> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final ValueNotifier<Color> _color = ValueNotifier<Color>(Colors.blue);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: 10,
      upperBound: 40,
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.addStatusListener(_statusListen);
    _controller.forward();
    // _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: PicManPainter(
          color: _color,
          angle: _controller,
          repaint: Listenable.merge([_controller, _color])), // 背景
    );
  }

  void _statusListen(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        _color.value = Colors.black;
        break;
      case AnimationStatus.forward:
        _color.value = Colors.blue;
        break;
      case AnimationStatus.reverse:
        _color.value = Colors.red;
        break;
      case AnimationStatus.completed:
        _color.value = Colors.green;
        break;
    }
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> angle;
  final Listenable repaint;
  final ValueNotifier<Color> color;

  PicManPainter({this.color, this.angle, this.repaint})
      : super(repaint: repaint);

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: Offset(0, 0), height: size.width, width: size.height);
    var a = angle.value / 180 * pi;
    canvas.drawArc(
        rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color.value);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant PicManPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
