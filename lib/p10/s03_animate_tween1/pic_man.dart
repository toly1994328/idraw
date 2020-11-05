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
  Animation<Color> _colorCtrl;
  Animation<double> _angleCtrl;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _angleCtrl = _controller.drive(Tween(begin: 10, end: 40));

    _colorCtrl =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: PicManPainter(
          color: _colorCtrl, angle: _angleCtrl, repaint: _controller),
    );
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> repaint;
  final Animation<double> angle;
  final Animation<Color> color;

  Paint _paint = Paint();

  PicManPainter({this.repaint, this.color, this.angle})
      : super(repaint: repaint);

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
  bool shouldRepaint(covariant PicManPainter oldDelegate)=> oldDelegate.repaint != repaint;
}
