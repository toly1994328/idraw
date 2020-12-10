import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

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


  List<Offset> points1 = [
    Offset(0, 20),
    Offset(40, 40) ,
    Offset(80, -20),
    Offset(120, -40),
    Offset(160, -80),
    Offset(200, -20),
    Offset(240, -40),
  ];
  List<Offset> points2 = [
    Offset(0, 0),
    Offset(40, -20) ,
    Offset(80, -40),
    Offset(120, -80),
    Offset(160, -40),
    Offset(200, 20),
    Offset(240, 40),
  ];
  List<Offset> helpPoints = [

  ];

  Paint _helpPaint = Paint();

  Path _linePath = Path();
  
  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;





    Path path = Path();
    addBezierPathWithPoints(path, points2);
    canvas.drawPath(path, paint);

    addBezierPathWithPoints(_linePath, points1);
    canvas.drawPath(_linePath, paint..color=Colors.orange);

    _drawHelp(canvas);
  }

  void addBezierPathWithPoints(Path path, List<Offset> points) {
    for (int i = 0; i < points.length - 1; i++) {
      Offset current = points[i];
      Offset next = points[i+1];
      if (i == 0) {
        path.moveTo(current.dx, current.dy);
        // 控制点
        double ctrlX = current.dx + (next.dx - current.dx) / 2;
        double ctrlY = next.dy;
        path.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
      } else if (i < points.length - 2) {
        // 控制点 1
        double ctrl1X = current.dx + (next.dx - current.dx) / 2;
        double ctrl1Y = current.dy;
        // 控制点 2
        double ctrl2X = ctrl1X;
        double ctrl2Y = next.dy;
        path.cubicTo(ctrl1X,ctrl1Y,ctrl2X,ctrl2Y,next.dx,next.dy);
      }else{
        // 控制点
        double ctrlX = (next.dx - current.dx) / 2;
        double ctrlY = 0;
        path.relativeQuadraticBezierTo(ctrlX, ctrlY, next.dx-current.dx, next.dy-current.dy);
      }
    }
  }

  void _drawHelp(Canvas canvas) {
    
    _helpPaint
      ..style = PaintingStyle.stroke;
    points1.forEach((element) {
      canvas.drawCircle(element, 2, _helpPaint..strokeWidth=1..color=Colors.orange);
    });

    points2.forEach((element) {
      canvas.drawCircle(element, 2, _helpPaint..strokeWidth=1..color=Colors.red);
    });

    // canvas.drawPoints(PointMode.polygon, points1, _helpPaint..strokeWidth=0.5..color=Colors.red);// _drawHelp(canvas);
    // canvas.drawPoints(PointMode.polygon, points2, _helpPaint..strokeWidth=0.5..color=Colors.red);// _drawHelp(canvas);
    // canvas.drawPoints(PointMode.polygon, helpPoints, _helpPaint..strokeWidth=0.5..color=Colors.red);// _drawHelp(canvas);



    // _helpPaint
    //   ..color = Colors.purple
    //   ..style = PaintingStyle.stroke
    //   ..strokeCap = StrokeCap.round;
    // canvas.drawPoints(PointMode.lines, [Offset.zero, p1, p1, p2],
    //     _helpPaint..strokeWidth = 1);
    // canvas.drawPoints(PointMode.points, [Offset.zero, p1, p1, p2],
    //     _helpPaint..strokeWidth = 8);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
