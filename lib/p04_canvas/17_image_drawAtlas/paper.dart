import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'coordinate.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸
///
class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  void initState() {
    super.initState();
    _loadImage();
  }


  void _loadImage() async {
    _image =
    await loadImageFromAssets('assets/images/shoot.png');
    setState(() {});
  }

  ui.Image? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(
            painter: PaperPainter(
              _image,
            )));
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final ui.Image? image;
  final Coordinate coordinate = Coordinate();

  final List<Sprite> allSprites = [];

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) {
      return;
    }
    coordinate.paint(canvas, size);

    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 325, 257, 166),
        offset: Offset(0, 0),
        alpha: 255,
        rotation: 0));

    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 325, 257, 166),
        offset: Offset(257, 130),
        alpha: 255,
        rotation: 0));

    final List<RSTransform> transforms = allSprites
        .map((sprite) => RSTransform.fromComponents(
              rotation: sprite.rotation,
              scale: 1.0,
              anchorX: sprite.anchor.dx,
              anchorY: sprite.anchor.dy,
              translateX: sprite.offset.dx,
              translateY: sprite.offset.dy,
            ))
        .toList();

    final List<Rect> rects =
        allSprites.map((sprite) => sprite.position).toList();

    canvas.drawAtlas(image!, transforms, rects, null, null, null, _paint);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => image != oldDelegate.image;
}

class Sprite {
  Rect position; // 雪碧图 中 图片矩形区域
  Offset offset; // 移动偏倚
  Offset anchor; // 移动偏倚
  int alpha; // 透明度
  double rotation; // 旋转角度

  Sprite({this.offset=Offset.zero,this.anchor=Offset.zero, this.alpha=255, this.rotation=0,required this.position});
}
