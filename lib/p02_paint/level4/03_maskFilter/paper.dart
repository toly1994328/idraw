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
  ui.Image? _img;
  bool get hasImage => _img != null;
  
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    _loadImage();
    super.initState();
  }

  void _loadImage() async {
    _img = await loadImageFromAssets('assets/images/wy_200x300.jpg');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
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
  ui.Image? img;

  PaperPainter(this.img);
  
  @override
  void paint(Canvas canvas, Size size) {
    if(img!=null) {
      drawMaskFilter(canvas);
    }
  }

  double get imgW => img!.width.toDouble();
  double get imgH => img!.height.toDouble();

  void drawMaskFilter(Canvas canvas) {
    var paint =Paint();
    _drawImage(canvas, paint,move: false);

    paint.maskFilter=MaskFilter.blur(BlurStyle.inner, 20);
    _drawImage(canvas, paint);

    paint.maskFilter=MaskFilter.blur(BlurStyle.outer, 3);
    _drawImage(canvas, paint);

    paint.maskFilter=MaskFilter.blur(BlurStyle.solid, 5);
    _drawImage(canvas, paint);

    paint.maskFilter=MaskFilter.blur(BlurStyle.normal, 3);
    _drawImage(canvas, paint);

  }

  void _drawImage(Canvas canvas, Paint paint,{bool move=true}) {
    if(move){
      canvas.translate(120, 0);
    }else{
      canvas.translate(20, 20);
    }
    canvas.drawImageRect(img!,
        Rect.fromLTRB(0, 0, imgW, imgH),
        Rect.fromLTRB(0, 0, imgW/2, imgH/2),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
