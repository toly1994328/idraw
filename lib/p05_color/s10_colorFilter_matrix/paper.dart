import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image _img;

  bool get hasImage => _img != null;

  @override
  void initState() {
    super.initState();
    _loadImage();
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
  ui.Image img;
  Coordinate coordinate = Coordinate();

  PaperPainter(this.img);

  @override
  void paint(Canvas canvas, Size size) {
    if (img == null) return;
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-120*2 - imgW / 4, -imgH / 4);
    drawColorFilter(canvas);
  }

  double get imgW => img.width.toDouble();

  double get imgH => img.height.toDouble();

  void drawColorFilter(Canvas canvas) {
    var paint = Paint();

    _drawImage(canvas, paint);

    const ColorFilter carveCarve = ColorFilter.matrix(<double>[
      -1, 0, 0, 0, 255,
      0, 0, 0, 0, 0,
      0, 0, 0, 0, 0,
      0, 0, 0, 1, 0,
    ]);
    paint.colorFilter = carveCarve;
    // _drawImage(canvas, paint);

    const ColorFilter negative = ColorFilter.matrix(<double>[
      -1, 0, 0, 0, 255,
      0, -1, 0, 0, 255,
      0, 0, -1,0, 255,
      0, 0, 0, 1, 0
    ]);
    paint.colorFilter = negative;
    // _drawImage(canvas, paint);

    const ColorFilter sepia = ColorFilter.matrix(<double>[
      0.393, 0.769, 0.189, 0, 0,
      0.349, 0.686, 0.168, 0, 0,
      0.272, 0.534, 0.131, 0 , 0,
      0,     0,     0,     1, 0,
    ]);
    _drawImage(canvas, paint..colorFilter=sepia);

    const ColorFilter greyscale = ColorFilter.matrix(<double>[
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0,      0,      0,      1, 0,
    ]);
    _drawImage(canvas, paint..colorFilter=greyscale);

    const n = 90.0;
    const ColorFilter light = ColorFilter.matrix(<double>[
      1,0,0,0,n,
      0,1,0,0,n,
      0,0,1,0,n,
      0,0,0,1,0
    ]);
    _drawImage(canvas, paint..colorFilter=light);

    const n2 = -126.0;
    const ColorFilter darken = ColorFilter.matrix(<double>[
      1,0,0,0,n2,
      0,1,0,0,n2,
      0,0,1,0,n2,
      0,0,0,1,0
    ]);
    _drawImage(canvas, paint..colorFilter=darken);

  }

  void _drawImage(Canvas canvas, Paint paint) {
    canvas.drawImageRect(img, Rect.fromLTRB(0, 0, imgW, imgH),
        Rect.fromLTRB(0, 0, imgW / 2, imgH / 2), paint);
    canvas.translate(120, 0);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
