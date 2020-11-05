import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class ICharts extends StatefulWidget {
  @override
  _IChartsState createState() => _IChartsState();
}

class _IChartsState extends State<ICharts> {
  // final List<Map<String, int>> data = [
  //   {
  //     "语文": 88,
  //     "数学": 98,
  //     "英语": 70,
  //     "物理": 80,
  //     "化学": 100,
  //     "生物": 75,
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 380,
          height: 260,
          padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          color: Colors.blueAccent.withAlpha(33),
          child: CustomPaint(
            painter: ChartPainter(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text(
            '2040年捷特数学成绩月考柱状图',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

// class DataSource{
//   String y;
//   String x;
// }

const double _kScaleHeight = 8;

class ChartPainter extends CustomPainter {
  final List<double> yData = [88, 98, 70, 80, 100, 75];
  final List<String> xData = ["7月", "8月", "9月", "10月", "11月", "12月"];

  // final List<String> xData = [ "语文","数学", "英语", "物理", "化学", "生物"];

  Path axisPath = Path();
  Paint manPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  Paint fillPaint = Paint()..color = Colors.red;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.black.withAlpha(22));

    canvas.translate(0, size.height);
    canvas.translate(_kScaleHeight, -_kScaleHeight);

    // canvas.scale(-1,1);
    // canvas.drawCircle(Offset.zero, 10, manPaint);
    axisPath.moveTo(-_kScaleHeight, 0);
    axisPath.relativeLineTo(size.width, 0);
    axisPath.moveTo(0, _kScaleHeight);
    axisPath.relativeLineTo(0, -size.height);
    canvas.drawPath(axisPath, manPaint..color);
    canvas.save();

    double maxY = yData.reduce(max);
    double step = (size.height - _kScaleHeight) / 5;
    double stepY = maxY / 5;

    for (int i = 0; i <= 5; i++) {
      if (i == 0) {
        canvas.translate(0, -step);
        continue;
      }
      canvas.drawLine(Offset(_kScaleHeight, 0), Offset(0, 0), manPaint);
      drawText(canvas, '${(stepY * i).toStringAsFixed(0)}',
          offset: Offset(-20, -5));
      canvas.translate(0, -step);
    }
    canvas.restore();

    // canvas.drawCircle(Offset.zero, 10, manPaint);

    // canvas.drawLine(Offset(0, _kScaleHeight), Offset(0, 0), manPaint);

    step = (size.width - _kScaleHeight) / xData.length;
    canvas.save();
    canvas.translate(step, 0);
    for (int i = 0; i < xData.length; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, _kScaleHeight), manPaint);
      drawText(canvas, xData[i], offset: Offset(-step + 20, 5));
// canvas.drawCircle(Offset.zero, 10, manPaint);
      canvas.drawRect(
          Rect.fromLTWH(
                  15, 0, 30, -(yData[i] / maxY * (size.height - _kScaleHeight)))
              .translate(-step, 0),
          fillPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void drawText(Canvas canvas, String str,
      {Offset offset = Offset.zero,
      Color color = Colors.black,
      double fountSize = 11,
      FontWeight fontWeight = FontWeight.normal}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(
            color: color,
            fontSize: fountSize,
            fontWeight: fontWeight,
            textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);

    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: fountSize * str.length)),
        offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
