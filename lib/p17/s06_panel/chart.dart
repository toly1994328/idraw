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
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )
        ..forward();
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
        width: 500,
        height: 380,
        padding: EdgeInsets.only(top: 20, right: 20, bottom: 20, left: 20),
        child: CustomPaint(
          painter: ChartPainter(repaint: _controller),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(top: 8.0),
      //   child: Text(
      //     "捷特 3 月支出统计图 - 2040 年",
      //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //   ),
      // )
    ]);
  }
}

const double _kPiePadding = 20; // 圆边距
const double _kStrokeWidth = 12; // 圆弧宽
const double _kAngle = 270; // 圆弧角度
const int _kMax = 220; // 最大刻度值
const int _kMin = 0; // 最小刻度值
const double _kColorStopRate = 0.2; // 颜色变化分率
const double _kScaleHeightLever1 = 14; // 短刻度线
const double _kScaleHeightLever2 = 18; // 逢5线
const double _kScaleHeightLever3 = 20; // 逢10线
const double _kScaleDensity = 0.5; // 密度
const double _kScaleTextStep = 10; // 刻度文字步长

const List<Color> _kColors = [
  // 颜色列表
  Colors.green,
  Colors.blue,
  Colors.red,
];

class ChartPainter extends CustomPainter {
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  double value = 150; //指针数值
  double radius = 0; // 圆半径

  final Animation<double> repaint;

  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  double get initAngle => (360 - _kAngle) / 2;

  ChartPainter({required this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide / 2 - _kPiePadding; // 当前圆半径
    canvas.translate(size.width / 2, size.height / 2); // 画布原点移至中点

    drawText(canvas);
    drawArrow(canvas); // 绘制指针
    canvas.rotate(pi / 2); // 将起始点旋转到 y 轴正方向
    drawScale(canvas); // 绘制刻度
    drawOutline(canvas); // 绘制弧线
  }

  void drawOutline(Canvas canvas) {
    Path path = Path()..moveTo(radius, 0);
    path.arcTo(
        Rect.fromCenter(
            center: Offset.zero, width: radius * 2, height: radius * 2),
        pi / 180 * initAngle,
        pi / 180 * _kAngle,
        true);

    PathMetrics pms = path.computeMetrics();
    stokePaint..strokeWidth = _kStrokeWidth;
    pms.forEach((PathMetric pm) {
      canvas.drawPath(pm.extractPath(0, pm.length * _kColorStopRate),
          stokePaint..color = _kColors[0]);
      canvas.drawPath(
          pm.extractPath(
              pm.length * _kColorStopRate, pm.length * (1 - _kColorStopRate)),
          stokePaint..color = _kColors[1]);
      canvas.drawPath(
          pm.extractPath(pm.length * (1 - _kColorStopRate), pm.length),
          stokePaint..color = _kColors[2]);
    });
  }

  void drawScale(Canvas canvas) {
    canvas.save();
    canvas.rotate(pi / 180 * initAngle);
    double len = 0;
    Color color = Colors.red;
    int count = (_kMax * _kScaleDensity).toInt(); // 格线个数
    for (int i = _kMin; i <= count; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        len = _kScaleHeightLever2;
      } else if (i % 10 == 0) {
        len = _kScaleHeightLever3;
      } else {
        len = _kScaleHeightLever1;
      }
      if (i < count * _kColorStopRate) {
        color = Colors.green;
      } else if (i < count * (1 - _kColorStopRate)) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      canvas.drawLine(Offset(radius + _kStrokeWidth / 2, 0),
          Offset(radius - len, 0), stokePaint..color = color..strokeWidth=1);
      canvas.rotate(pi / 180 / _kMax * _kAngle / _kScaleDensity);
    }
    canvas.restore();
  }

  void drawArrow(Canvas canvas) {
    var nowPer = value / _kMax;
    Color color = Colors.red;
    canvas.save();
    double radians = pi / 180 * (-_kAngle / 2 + nowPer * _kAngle*repaint.value);
    canvas.rotate(radians);
    Path arrowPath = Path();
    arrowPath.moveTo(0, 18);
    arrowPath.relativeLineTo(-6, -10);
    arrowPath.relativeLineTo(6, -radius + 10);
    arrowPath.relativeLineTo(6, radius - 10);
    arrowPath.close();

    if (nowPer < _kColorStopRate) {
      color = _kColors[0];
    } else if (nowPer < (1 - _kColorStopRate)) {
      color = _kColors[1];
    } else {
      color = _kColors[2];
    }

    canvas.drawPath(arrowPath, fillPaint..color = color);
    canvas.drawCircle(Offset.zero, 3, stokePaint..color = Colors.yellow..strokeWidth=1);
    canvas.drawCircle(Offset.zero, 3, fillPaint..color = Colors.white);
    canvas.restore();
  }

  void drawText(Canvas canvas) {
    _drawAxisText(canvas, 'km/s',
        fontSize: 20,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        alignment: Alignment.center,
        color: Colors.black,
        offset: Offset(0, -radius / 2));

    _drawAxisText(canvas, '${value.toStringAsFixed(1)}',
        fontSize: 16,
        alignment: Alignment.center,
        color: Colors.black,
        offset: Offset(0, radius / 2));

    int count = (_kMax - _kMin) * _kScaleDensity ~/ _kScaleTextStep;
    Color color = Colors.red;
    for (int i = _kMin; i <= count; i++) {
      var thta = pi / 180 * (90 + initAngle + (_kAngle / count) * i);
      if (i < count * _kColorStopRate) {
        color = _kColors[0];
      } else if (i < count * (1 - _kColorStopRate)) {
        color = _kColors[1];
      } else {
        color = _kColors[2];
      }

      Rect rect = Rect.fromLTWH((radius - 40) * cos(thta) - 12,
          (radius - 40) * sin(thta) - 8, 24, 16);

      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(3)),
          fillPaint..color = color);
      _drawAxisText(canvas, '${i * _kScaleTextStep ~/ _kScaleDensity}',
          fontSize: 11,
          alignment: Alignment.center,
          color: Colors.white,
          offset: Offset((radius - 40) * cos(thta), (radius - 40) * sin(thta)));
    }
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black,
      double fontSize = 11,
      FontStyle fontStyle = FontStyle.normal,
      Alignment alignment = Alignment.centerRight,
      FontWeight fontWeight = FontWeight.normal,
      Offset offset = Offset.zero}) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
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
