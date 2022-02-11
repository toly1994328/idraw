import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image? _srcImage;
  ui.Image? _dstImage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _srcImage = await loadImageFromAssets('assets/images/src.png');
    _dstImage = await loadImageFromAssets('assets/images/dst.png');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(painter: PaperPainter(_srcImage, _dstImage)));
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

}

class PaperPainter extends CustomPainter {
  final ui.Image? srcImage;
  final ui.Image? dstImage;

  PaperPainter(this.srcImage, this.dstImage);

  static const double step = 20; // 方格变长
  final Coordinate coordinate = Coordinate(step: step);


  @override
  void paint(Canvas canvas, Size size) {
    if (dstImage == null || srcImage == null) return;

    Paint srcPaint = Paint();
    Paint dstPaint = Paint();

    int index = 4;

    BlendMode srcModel = BlendMode.dstOver;
    BlendMode dstModel = BlendMode.srcOver;

    srcPaint
      ..blendMode = srcModel;
    dstPaint
      ..blendMode = dstModel;

    _simpleDrawText(canvas, BlendMode.values[index].toString().split(".")[1],
        fontSize: 16,
        offset: Offset(50, 50));

    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawImageRect(
        dstImage!,
        Rect.fromPoints(
            Offset.zero, Offset(dstImage!.width * 1.0, dstImage!.height * 1.0)),
        Rect.fromCenter(
            center: Offset.zero, width: 400, height: 400),
        dstPaint);

    canvas.drawImageRect(
        srcImage!,
        Rect.fromPoints(
            Offset.zero, Offset(srcImage!.width * 1.0, srcImage!.height * 1.0)),
        Rect.fromCenter(
            center: Offset.zero, width: 400, height: 400),
        srcPaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _simpleDrawText(Canvas canvas, String str,
      {double fontSize = 11,Offset offset = Offset.zero, Color color = Colors.black}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: fontSize,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(color: color, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);

    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: fontSize * str.length)),
        offset);
  }
}
