import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸
class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  image.Image? _image;
  List<Ball> balls = [];
  double d = 20; //复刻的像素边长

  @override
  void initState() {
    super.initState();
    _initBalls();
  }

  void _initBalls() async {
    _image = await loadImageFromAssets('assets/images/icon_head.png');
    if (_image == null) return;
    for (int i = 0; i < _image!.width; i++) {
      for (int j = 0; j < _image!.height; j++) {
        Ball ball = Ball();
        ball.x = i * d + d / 2;
        ball.y = j * d + d / 2;
        ball.r = d / 2;
        var color = Color(_image!.getPixel(i, j));
        ball.color =
            Color.fromARGB(color.alpha, color.blue, color.green, color.red);
        balls.add(ball);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PaperPainter(balls),
        ));
  }

  //读取 assets 中的图片
  Future<image.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List();
    return image.decodeImage(bytes);
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final List<Ball> balls;
  final Coordinate coordinate = Coordinate();

  PaperPainter(this.balls) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(-710, -1000);
    _drawImage(canvas);
  }

  void _drawImage(Canvas canvas) {
    balls.forEach((Ball ball) {
      canvas.drawCircle(
          Offset(ball.x, ball.y), ball.r, _paint..color = ball.color);
    });
  }


  @override
  bool shouldRepaint(PaperPainter oldDelegate) => balls != oldDelegate.balls;

}

class Ball {
  double x; //点位X
  double y; //点位Y
  Color color; //颜色
  double r; // 半径

  Ball({this.x=0, this.y=0, this.color=Colors.black, this.r=5});

}
