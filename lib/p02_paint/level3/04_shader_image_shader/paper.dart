import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image _img;
  bool get hasImage => _img != null;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: hasImage
          ? CustomPaint(
              painter: ImageShaderPainter(_img),
            )
          : Container(),
    );
  }

  void _loadImage() async {
    _img = await loadImage(AssetImage('assets/images/wy_200x300.jpg'));
    setState(() {});
  }

  //异步加载图片成为ui.Image
  Future<ui.Image> loadImage(ImageProvider provider) {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageStreamListener listener;
    ImageStream stream = provider.resolve(ImageConfiguration());
    listener = ImageStreamListener((info, syno) {
      final ui.Image image = info.image; //监听图片流，获取图片
      completer.complete(image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }
}

class ImageShaderPainter extends CustomPainter {
  ui.Image img;
  Paint _paint;

  ImageShaderPainter(this.img) {
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(img);
    _paint.shader = ImageShader(
        img,
        TileMode.repeated,
        TileMode.repeated,
        Float64List.fromList([
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1,
        ]));

    canvas.drawCircle(Offset(100, 100), 50, _paint);
    canvas.drawCircle(
        Offset(100 + 120.0, 100),
        50,
        _paint
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke);
    canvas.drawLine(
        Offset(100 + 120.0 * 2, 50),
        Offset(100 + 120.0 * 2, 50 + 100.0),
        _paint
          ..strokeWidth = 30
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
