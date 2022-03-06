import 'dart:math';
import 'dart:ui';

// import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class ICharts extends StatefulWidget {
  @override
  _IChartsState createState() => _IChartsState();
}

class _IChartsState extends State<ICharts> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
        ..forward()
        ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Container(
        width: 350,
        height: 250,
        padding: EdgeInsets.only(top: 40, right: 20, bottom: 20, left: 20),
        child: CustomPaint(
          painter: ChartPainter(repaint: _controller),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "捷特数学成绩统计图 - 2040 年",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}

const double _kScaleHeight = 8; // 刻度高
const double _kBarPadding = 10; // 柱状图前间隔

class ChartPainter extends CustomPainter {
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  final List<double> yData = [88, 98, 70, 80, 100, 75];
  final List<String> xData = ["7月", "8月", "9月", "10月", "11月", "12月"];

  // final List<String> xData = [ "语文","数学", "英语", "物理", "化学", "生物"];

  final Animation<double> repaint;

  Path axisPath = Path();
  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;
  Paint fillPaint = Paint()..color = Colors.red;
  Paint linePaint = Paint()
    ..color = Colors.orange
    ..strokeCap=StrokeCap.round
    ..style = PaintingStyle.stroke;

  double xStep = 0; // x 间隔
  double yStep = 0; // y 间隔

  double maxData = 0; // 数据最大值

  final List<Offset> line = []; // 折线点位信息

  ChartPainter({required this.repaint}) : super(repaint: repaint) {
    maxData = yData.reduce(max);
  }

  @override
  void paint(Canvas canvas, Size size) {
    xStep = (size.width - _kScaleHeight) / xData.length;
    yStep = (size.height - _kScaleHeight) / 5;

    canvas.translate(0, size.height);
    canvas.translate(_kScaleHeight, -_kScaleHeight);
    axisPath.moveTo(-_kScaleHeight, 0);
    axisPath.relativeLineTo(size.width, 0);
    axisPath.moveTo(0, _kScaleHeight);
    axisPath.relativeLineTo(0, -size.height);
    canvas.drawPath(axisPath, axisPaint);

    drawYText(canvas, size);
    drawXText(canvas, size);
    collectPoints(canvas, size);
    drawLineChart(canvas);
  }

  void drawXText(Canvas canvas, Size size) {

    canvas.save();
    canvas.translate(xStep, 0);
    for (int i = 0; i < xData.length; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, _kScaleHeight), axisPaint);
      _drawAxisText(canvas, xData[i],
          alignment: Alignment.center, offset: Offset(-xStep / 2, 10));
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  void collectPoints(Canvas canvas, Size size) {
    line.clear();
    canvas.translate(xStep, 0);
    for (int i = 0; i < xData.length; i++) {
      double dataHeight = -(yData[i] / maxData * (size.height - _kScaleHeight));
      line.add(Offset(xStep * i-xStep/2, dataHeight));
    }
  }

  void drawLineChart(Canvas canvas){
    canvas.drawPoints(PointMode.points, line, linePaint..strokeWidth=5);
    Path path = Path();
    addBezierPathWithPoints(path, line);
    linePaint..strokeWidth=1;
    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      canvas.drawPath(pm.extractPath(0, pm.length * repaint.value), linePaint);
    });
  }

  void drawYText(Canvas canvas, Size size) {
    canvas.save();
    double numStep = maxData / 5;
    for (int i = 0; i <= 5; i++) {
      if (i == 0) {
        _drawAxisText(canvas, '0', offset: Offset(-10, 2));
        canvas.translate(0, -yStep);
        continue;
      }

      canvas.drawLine(
          Offset(0, 0), Offset(size.width - _kScaleHeight, 0), gridPaint);

      canvas.drawLine(Offset(-_kScaleHeight, 0), Offset(0, 0), axisPaint);
      String str = '${(numStep * i).toStringAsFixed(0)}';
      _drawAxisText(canvas, str, offset: Offset(-10, 2));
      canvas.translate(0, -yStep);
    }
    canvas.restore();
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

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black,
      bool x = false,
      Alignment alignment = Alignment.centerRight,
      Offset offset = Offset.zero}) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: 11,
          color: color,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2)
        .translate(-size.width / 2 * alignment.x + offset.dx, 0.0 + offset.dy);
    _textPainter.paint(canvas, offsetPos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}
