import 'dart:math';
import 'dart:ui';

// import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idraw/p18/s01/particle.dart';

import 'particle_manage.dart';
import 'world_render.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
 late AnimationController _controller;
  ParticleManage pm = ParticleManage();

  @override
  void initState() {
    super.initState();
    initParticleManage();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(pm.tick)
      // ..repeat()
    ;
  }

  void initParticleManage() {
    pm.size = Size(300, 200);
    Particle particle = Particle(x: 0, y: 0, vx: 3, vy: 0,ay: 0.05,
        color: Colors.blue, size: 8);
    pm.particles = [particle];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld(){
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }
}

