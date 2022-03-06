import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..repeat()
    ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(
            CurveTween(curve: Curves.linear).animate(_controller)),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {

  final Animation<double> repaint;

  PaperPainter(this.repaint) : super(repaint: repaint);

  double waveWidth = 80;
  double wrapHeight = 100;
  double waveHeight = 10;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.clipRect((Rect.fromCenter(
        center: Offset(waveWidth, 0), width: waveWidth * 2, height: 200.0)));

    Paint paint = Paint();

    Path path  = getWavePath();
    canvas.translate(-4 * waveWidth + 2 * waveWidth * repaint.value, 0);
    canvas.drawPath(path, paint..color = Colors.orange);

    canvas.translate(2*waveWidth* repaint.value, 0);
    canvas.drawPath(path, paint..color = Colors.orange.withAlpha(88));

  }

  Path getWavePath() {
    Path path = Path();
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeLineTo(0, wrapHeight);
    path.relativeLineTo(-waveWidth * 3 * 2.0, 0);
    return path;
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
