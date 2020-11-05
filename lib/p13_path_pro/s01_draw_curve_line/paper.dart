import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui'as ui;
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

  final List<Offset> points = [];

  final double step = 1;
  final double min = 0;
  final double max = 360;

  void initPoints() {
    for (double x = min; x <= max; x += step) {
      points.add(Offset(x, f(x)));
      // double thta = (pi / 180 * x);
      // var p = f(thta);
      // points.add(Offset(p * cos(thta), p * sin(thta)));
    }
  }

  void initPointsWithPolar() {
    for (double x = min; x <= max; x += step) {
      double thta = (pi / 180 * x); // 角度转化为弧度
      var p = f(thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
  }

  // double f(double x) {
  //   double y = -x * x / 200 + 100;
  //   return y;
  // }

  // double f(double thta) {
  //   double p = 10 * thta;
  //   return p;
  // }

  // double f(double thta) {
  //   double p = 100 * (1-cos(thta));
  //   return p;
  // }

  // double f(double thta) {
  //   double p = 150*sin(5*thta).abs();
  //   return p;
  // }


  double f(double thta) { // 100*(1-4*sinθ)
    double p =  50*(pow(e,cos(thta)) - 2 * cos(4 * thta) +pow(sin(thta / 12), 5));
    return p;
  }


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    // initPoints();
    initPointsWithPolar();
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100, 0), colors, pos,TileMode.mirror);

    // canvas.drawPoints(PointMode.points, points, paint);
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
