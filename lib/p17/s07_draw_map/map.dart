import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'map_root.dart';

class ChinaMap extends StatefulWidget {
  @override
  _ChinaMapState createState() => _ChinaMapState();
}

class _ChinaMapState extends State<ChinaMap> {
  final String url =
      'https://geo.datav.aliyun.com/areas_v2/bound/100000_full.json'; //全国点位详细信息

  //请求点位信息地址
  Future<MapRoot> getMapRoot() async {
    try {
      final Response response = await Dio().get(url);
      if (response.data != null) {
        return MapRoot.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<MapRoot> _future;

  @override
  void initState() {
    super.initState();
    _future = getMapRoot();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MapRoot>(
      future: _future,
      builder: (context, async) {
        print(async.hasData);
        if (async.hasData) {
          return CustomPaint(
            size: Size(700, 600),
            painter: MapPainter(mapRoot: async.data),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}

class MapPainter extends CustomPainter {
  final MapRoot mapRoot; //点位信息

  Paint _paint;
  final List<Color> colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  int colorIndex = 0;

  MapPainter({this.mapRoot}) {
    _paint = Paint()
      ..strokeWidth = 0.1
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {

    canvas.clipRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-mapRoot.features[0].geometry.coordinates[0][0][0].dx,
        -mapRoot.features[0].geometry.coordinates[0][0][0].dy);

    canvas.translate(-700, 320);
    canvas.scale(8, -10.5);

    _drawMap(canvas, size);
  }


  void _drawMap(Canvas canvas, Size size) {
    //全国省份循环
    for (int i = 0; i < mapRoot.features.length; i++) {
      var features = mapRoot.features[i];
      PaintingStyle style;
      Color color;
      Path path = Path();
      if (features.properties.name == "台湾省" ||
          features.properties.name == "海南省" ||
          features.properties.name == "河北省" ||
          features.properties.name == "") { //海南和台湾和九段线
        features.geometry.coordinates.forEach((List<List<Offset>> lv3) {
          lv3.forEach((List<Offset> lv2) {
            path.moveTo(lv2[0].dx, lv2[0].dy);
            lv2.forEach((Offset lv1) {
              path.lineTo(lv1.dx, lv1.dy); //优化一半点位
            });
          });
        });

        if (features.properties.name == "") {
          style = PaintingStyle.stroke;
          color = Colors.black;
        } else {
          style = PaintingStyle.fill;
          color = colors[colorIndex % 4];
        }
        colorIndex++;
      } else {
        final Offset first = features.geometry.coordinates[0][0][0];
        path.moveTo(first.dx, first.dy);
        for (Offset d in features.geometry.coordinates.first.first) {
          path.lineTo(d.dx, d.dy);
        }
        style = PaintingStyle.fill;
        color = colors[colorIndex % 4];
        colorIndex++;
      }

      canvas.drawPath(path, _paint..color = color..style = style); //绘制地图
    }
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) => oldDelegate.mapRoot != mapRoot;
}
