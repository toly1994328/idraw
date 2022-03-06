import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../coordinate_pro.dart';
import 'touch_info.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  final TouchInfo touchInfo = TouchInfo();

  //单位圆(即半径为1)控制线长
  final rate = 0.551915024494;
  double _radius = 150;

  @override
  void initState() {
    super.initState();
    touchInfo.setPoints(_initPoints());
  }

  @override
  void dispose() {
    touchInfo.dispose();
    super.dispose();
  }

  List<Offset> _initPoints() {
    final List<Offset> pos = [];
    //第一段线
    pos.add(Offset(0, rate) * _radius);
    pos.add(Offset(1 - rate, 1) * _radius);
    pos.add(Offset(1, 1) * _radius);
    //第二段线
    pos.add(Offset(1 + rate, 1) * _radius);
    pos.add(Offset(2, rate) * _radius);
    pos.add(Offset(2, 0) * _radius);
    //第三段线
    pos.add(Offset(2, -rate) * _radius);
    pos.add(Offset(1 + rate, -1) * _radius);
    pos.add(Offset(1, -1) * _radius);
    //第四段线
    pos.add(Offset(1 - rate, -1) * _radius);
    pos.add(Offset(0, -rate) * _radius);
    pos.add(Offset(0, 0));
    return pos;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PaperPainter(repaint: touchInfo),
        ),
      ),
    );
  }

  void _onPanDown(DragDownDetails details) {
    if (touchInfo.points.length < 4) {
      touchInfo.addPoint(details.localPosition);
    } else {
      judgeZone(details.localPosition);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    judgeZone(details.localPosition, update: true);
  }

  ///判断出是否在某点的半径为r圆范围内
  bool judgeCircleArea(Offset src, Offset dst, double r) =>
      (src - dst).distance <= r;

  //判断哪个点被选中
  void judgeZone(Offset src, {bool update = false}) {
    Size size = MediaQuery.of(context).size;
    src= src.translate(-size.width/2, -size.height/2);
    for (int i = 0; i < touchInfo.points.length; i++) {
      if (judgeCircleArea(src, touchInfo.points[i], 15)) {
        touchInfo.selectIndex = i;
        if (update) {
          touchInfo.updatePoint(i, src);
        }
      }
    }
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  Paint _helpPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final TouchInfo repaint;

  PaperPainter({required this.repaint}) : super(repaint: repaint);
  List<Offset> pos = [];

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    pos = repaint.points;

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path.moveTo(0, 0);
    for (int i = 0; i < pos.length / 3; i++) {
      path.cubicTo(pos[3 * i + 0].dx, pos[3 * i + 0].dy, pos[3 * i + 1].dx,
          pos[3 * i + 1].dy, pos[3 * i + 2].dx, pos[3 * i + 2].dy);
    }

    canvas.drawPath(path, paint);
    _drawHelp(canvas);
    _drawSelectPos(canvas, size);
  }

  void _drawHelp(Canvas canvas) {

    _helpPaint..strokeWidth = 1..color=Colors.purple;
    canvas.drawLine(pos[0], pos[11], _helpPaint);
    canvas.drawLine(pos[1], pos[2], _helpPaint);
    canvas.drawLine(pos[2], pos[3], _helpPaint);
    canvas.drawLine(pos[4], pos[5], _helpPaint);
    canvas.drawLine(pos[5], pos[6], _helpPaint);
    canvas.drawLine(pos[7], pos[8], _helpPaint);
    canvas.drawLine(pos[8], pos[9], _helpPaint);
    canvas.drawLine(pos[10], pos[11], _helpPaint);
    canvas.drawLine(pos[11], pos[0], _helpPaint);
    canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
  }

  void _drawSelectPos(Canvas canvas, Size size) {
    Offset? selectPos = repaint.selectPoint;
    if (selectPos == null) return;

    canvas.drawCircle(selectPos, 10,
        _helpPaint..color = Colors.green..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
