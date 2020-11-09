import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'particle.dart';
import 'particle_manage.dart';
import 'world_render.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class World extends StatefulWidget {
  final Size size;

  World({Key key, this.size}) : super(key: key);

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ParticleManage pm = ParticleManage();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    loadImageFromAssets("assets/images/sword.png");
    pm.size = widget.size;

    initParticles();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(pm.tick)
        ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: widget.size.width,
            height: widget.size.height,
            child: Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
            )),
        GestureDetector(
          onTap: theWorld,
          child: CustomPaint(
            size: pm.size,
            painter: WorldRender(
              manage: pm,
            ),
          ),
        ),
      ],
    );
  }

  //读取 assets 中的图片
  void loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    pm.setImage(await decodeImageFromList(bytes));
  }

  void initParticles() {
    for (int i = 0; i < 60; i++) {
      Particle particle = Particle(
          x: pm.size.width / 60 * i,
          y: 0,
          vx: 1 * random.nextDouble() * pow(-1, random.nextInt(20)),
          vy: 4 * random.nextDouble() + 1);
      pm.particles.add(particle);
    }
  }
}
