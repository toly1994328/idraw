import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'coordinate.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸
class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image =
        await loadImageFromAssets('assets/images/wy_300x200.jpg');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white, child: CustomPaint(painter: PaperPainter(_image)));
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }
}

class PaperPainter extends CustomPainter {
  Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final ui.Image image;
  final Coordinate coordinate = Coordinate();

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImage(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      image != oldDelegate.image;

  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          image, Offset(-image.width / 2, -image.height / 2), _paint);
    }
  }
}
