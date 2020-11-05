import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image _srcImage;
  ui.Image _dstImage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _srcImage = await loadImageByProvider(AssetImage('assets/images/src.png'));
    _dstImage = await loadImageByProvider(AssetImage('assets/images/dst.png'));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(painter: PaperPainter(_srcImage, _dstImage)));
  }

  //通过ImageProvider读取Image
  Future<ui.Image> loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStream stream = provider.resolve(config); //获取图片流
    // 通过监听 ImageStream 获取流中数据
    ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      completer.complete(frame.image); //完成
      stream.removeListener(listener); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }
}

class PaperPainter extends CustomPainter {
  final ui.Image srcImage;
  final ui.Image dstImage;

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
        dstImage,
        Rect.fromPoints(
            Offset.zero, Offset(dstImage.width * 1.0, dstImage.height * 1.0)),
        Rect.fromCenter(
            center: Offset.zero, width: 400, height: 400),
        dstPaint);

    canvas.drawImageRect(
        srcImage,
        Rect.fromPoints(
            Offset.zero, Offset(srcImage.width * 1.0, srcImage.height * 1.0)),
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
