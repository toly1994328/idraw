import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image? _img;

  bool get hasImage => _img != null;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _img = await loadImageFromAssets('assets/images/wy_200x300.jpg');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PaperPainter(_img),
        ));
  }
}

class PaperPainter extends CustomPainter {
  ui.Image? img;

  PaperPainter(this.img);

  @override
  void paint(Canvas canvas, Size size) {
    if (img == null) return;
    drawColorFilter(canvas);
  }

  double get imgW => img?.width.toDouble()??0;

  double get imgH => img?.height.toDouble()??0;

  void drawColorFilter(Canvas canvas) {
    var paint = Paint();
    paint.colorFilter = ColorFilter.linearToSrgbGamma();
    _drawImage(canvas, paint, move: false);

    paint.colorFilter = ColorFilter.mode(Colors.yellow, BlendMode.modulate);
    _drawImage(canvas, paint);

    paint.colorFilter = ColorFilter.mode(Colors.yellow, BlendMode.difference);
    _drawImage(canvas, paint);

    paint.colorFilter = ColorFilter.mode(Colors.blue, BlendMode.plus);
    _drawImage(canvas, paint);

    paint.colorFilter = ColorFilter.mode(Colors.blue, BlendMode.lighten);
    _drawImage(canvas, paint);
  }

  void _drawImage(Canvas canvas, Paint paint, {bool move = true}) {
    if (move) {
      canvas.translate(120, 0);
    } else {
      canvas.translate(20, 20);
    }
    canvas.drawImageRect(img!, Rect.fromLTRB(0, 0, imgW, imgH),
        Rect.fromLTRB(0, 0, imgW / 2, imgH / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
