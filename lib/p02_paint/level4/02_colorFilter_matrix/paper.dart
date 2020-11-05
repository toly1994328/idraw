import 'dart:async';

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
  ui.Image _img;
  bool get hasImage => _img != null;
  
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    _loadImage();
    super.initState();
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
      child: hasImage ? CustomPaint(
        painter: PaperPainter(_img) ,
      ): Container(),
    );
  }
}

class PaperPainter extends CustomPainter {
  ui.Image img;

  PaperPainter(this.img);
  
  @override
  void paint(Canvas canvas, Size size) {
    if(img!=null) {
      drawColorFilter(canvas);
    }
  }

  double get imgW => img.width.toDouble();
  double get imgH => img.height.toDouble();
  
  void drawColorFilter(Canvas canvas) {
    var paint =Paint();
    const ColorFilter identity = ColorFilter.matrix(<double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ]);
    _drawImage(canvas, paint..colorFilter=identity,move: false);

    const ColorFilter sepia = ColorFilter.matrix(<double>[
      0.393, 0.769, 0.189, 0, 0,
      0.349, 0.686, 0.168, 0, 0,
      0.272, 0.534, 0.131, 0 , 0,
      0,     0,     0,     1, 0,
    ]);
    _drawImage(canvas, paint..colorFilter=sepia);

    const ColorFilter invert = ColorFilter.matrix(<double>[
      -1,  0,  0, 0, 255,
      0, -1,  0, 0, 255,
      0,  0, -1, 0, 255,
      0,  0,  0, 1,   0,
    ]);
    _drawImage(canvas, paint..colorFilter=invert);

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
  }

  void _drawImage(Canvas canvas, Paint paint,{bool move=true}) {
    if(move){
      canvas.translate(120, 0);
    }else{
      canvas.translate(20, 20);
    }
    canvas.drawImageRect(img,
        Rect.fromLTRB(0, 0, imgW, imgH),
        Rect.fromLTRB(0, 0, imgW/2, imgH/2),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
