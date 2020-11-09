import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'bg_fx.dart';
import 'clock_bg_particle_painter.dart';
import 'palette.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明: 

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin{
  BgFx _bgFx;
  Ticker _ticker;
  Palette _palette;

  @override
  void initState() {
    _ticker = createTicker(_tick)..start();
    _bgFx = BgFx(
      size: Size(300, 200),
      time: DateTime.now(),
    );
    _init();
    super.initState();
  }


  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      color: Color(0xff98D9B6).withAlpha(22),
        width: 300,
        height: 200,
        child: _buildBgBlurFx()));
  }

  void _init() async{
    List<Palette> palettes = await _loadPalettes();
    _palette =  palettes[4];
    _bgFx.setPalette(_palette);
    setState(() {

    });
  }

  Future<List<Palette>> _loadPalettes() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/palettes.json");
    var palettes = json.decode(data) as List;
    return palettes.map((p) => Palette.fromJson(p)).toList();
  }


  Widget _buildBgBlurFx() {
    return
      RepaintBoundary(
      child: Stack(
        children: <Widget>[
      CustomPaint(

        painter: ClockBgParticlePainter(
          fx: _bgFx,
        ),
        child: Container(),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 300 * .05,
                sigmaY: 0,
              ),
              // filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(child: Text(" ")),
            ),
          ],
        ),
      );
  }


  void _tick(Duration duration) {
    if (DateTime.now().second % 5 == 0) _bgFx.tick(duration);
  }
}
