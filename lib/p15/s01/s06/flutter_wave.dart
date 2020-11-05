import 'dart:ui';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-04
/// contact me by email 1981462002@qq.com
/// 说明: 贝塞尔曲线测试画布
///

class FlutterWaveLoading extends StatefulWidget {
  final double width;
  final double height;
  final double waveHeight;
  final Color color;
  final double strokeWidth;
  final double progress;
  final double factor;
  final int secondAlpha;
  final double borderRadius;
  final bool isOval;

  FlutterWaveLoading(
      {
        this.width = 100,
        this.height = 100/0.618,
        this.factor = 1,
        this.waveHeight = 5,
        this.progress = 0.5,
        this.color = Colors.green,
        this.strokeWidth = 3,
        this.secondAlpha = 88,
        this.isOval = false,
        this.borderRadius = 20});

  @override
  _FlutterWaveLoadingState createState() => _FlutterWaveLoadingState();
}

class _FlutterWaveLoadingState extends State<FlutterWaveLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _anim;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..addListener(() {
            setState(() {});
          })
          ..repeat();
    _anim = CurveTween(curve: Curves.linear).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          painter: BezierPainter(
              factor: _anim.value,
              waveHeight: widget.waveHeight,
              progress: widget.progress,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
              secondAlpha: widget.secondAlpha,
              isOval: widget.isOval,
              borderRadius: widget.borderRadius),
        ),
      ),
    );
  }
}

class BezierPainter extends CustomPainter {
  Paint _mainPaint;
  Path _mainPath;

  double waveWidth = 80;
  double wrapHeight;

  final double waveHeight;
  final Color color;
  final double strokeWidth;
  final double progress;
  final double factor;
  final int secondAlpha;
  final double borderRadius;
  final bool isOval;

  BezierPainter(
      {this.factor = 1,
      this.waveHeight = 8,
      this.progress = 0.5,
      this.color = Colors.green,
      this.strokeWidth = 3,
      this.secondAlpha = 88,
      this.isOval = false,
      this.borderRadius = 20}) {
    _mainPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    _mainPath = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    waveWidth = size.width / 2;
    wrapHeight = size.height;

    Path path = Path();
    if (!isOval) {
      path.addRRect(
          RRect.fromRectXY(Offset(0, 0) & size, borderRadius, borderRadius));
      canvas.clipPath(path);
      canvas.drawPath(
          path,
          _mainPaint
            ..strokeWidth = strokeWidth
            ..color = color);
    }
    if (isOval) {
      path.addOval(Offset(0, 0) & size);
      canvas.clipPath(path);
      canvas.drawPath(
          path,
          _mainPaint
            ..strokeWidth = strokeWidth
            ..color = color);
    }
    canvas.translate(0, wrapHeight);
    canvas.save();
    canvas.translate(0, waveHeight);
    canvas.save();
    canvas.translate(-4 * waveWidth + 2 * waveWidth * factor, 0);
    drawWave(canvas);
    canvas.drawPath(
        _mainPath,
        _mainPaint
          ..style = PaintingStyle.fill
          ..color = color.withAlpha(88));
    canvas.restore();

    canvas.translate(-4 * waveWidth + 2 * waveWidth * factor * 2, 0);
    drawWave(canvas);
    canvas.drawPath(
        _mainPath,
        _mainPaint
          ..style = PaintingStyle.fill
          ..color = color);
    canvas.restore();
  }

  void drawWave(Canvas canvas) {
    _mainPath.moveTo(0, 0);
    _mainPath.relativeLineTo(0, -wrapHeight * progress);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    _mainPath.relativeLineTo(0, wrapHeight);
    _mainPath.relativeLineTo(-waveWidth * 3 * 2.0, 0);
//    _mainPath.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
