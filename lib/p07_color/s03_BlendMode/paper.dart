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
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image =
    await loadImageFromAssets('assets/images/icon_head.png');
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
        color: Colors.white, child: CustomPaint(painter: PaperPainter(_image)));
  }


}

class PaperPainter extends CustomPainter {

  final ui.Image? image;


  PaperPainter(this.image);

  static const double step = 20; // 方格变长
  final Coordinate coordinate = Coordinate(step: step);

  // 颜色列表 256 个元素
  final List<Color> colors =
      List<Color>.generate(256, (i) => Color.fromARGB(255 - i, 255, 0, 0));

  @override
  void paint(Canvas canvas, Size size) {
    if(image ==null) return;

    Paint srcPaint = Paint();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-step * 17, -step * 7);
    Paint dstPaint = Paint();
    BlendMode.values.asMap().forEach((i, value) {
      int line = i ~/ 10;
      int row = i % 10;
      canvas.save();

      canvas.translate(3.7 * step * row, 5.5 * step * line);
      canvas.drawImageRect(image!, Rect.fromPoints(Offset.zero, Offset(image!.width*1.0,image!.height*1.0)),
          Rect.fromCenter(center:Offset.zero, width: 25*2.0,height: 25*2.0), dstPaint);

      srcPaint
        ..color = Color(0xffff0000)
        ..blendMode = value;
      canvas.drawRect(
          Rect.fromPoints(Offset.zero, Offset(20 * 2.0, 20 * 2.0)), srcPaint);

      _simpleDrawText(canvas,value.toString().split(".")[1],offset: Offset(-10, 50));
      canvas.restore();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _simpleDrawText(Canvas canvas, String str,
      {Offset offset = Offset.zero, Color color = Colors.black}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 11,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
        ui.TextStyle(color: color, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);

    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: 11.0 * str.length)),
        offset);
  }
}
