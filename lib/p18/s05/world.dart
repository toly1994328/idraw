import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'particle.dart';
import 'package:image/image.dart' as image;
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
  Random random = Random();

  @override
  void initState() {
    super.initState();

    pm.size = Size(400, 260);

    initParticles();

    // pm.addParticle(Particle(
    //     color: Colors.blue,
    //     size: 50,
    //     vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //     vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //     ay: 0.1,
    //     ax: 0.1,
    //     x: 150,
    //     y: 100));

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(pm.tick)
        // ..repeat()
        ;
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
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }

  void initParticles() async {
    ByteData data = await rootBundle.load("assets/images/flutter.png");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    image.Image? imageSrc = image.decodeImage(bytes);
    if(imageSrc==null) return;

    double offsetX=  (pm.size.width-imageSrc.width)/2;
    double offsetY=  (pm.size.height-imageSrc.height)/2;

    for (int i = 0; i < imageSrc.width; i++) {
      for (int j = 0; j < imageSrc.height; j++) {
        print('-($i,$j)----${imageSrc.getPixel(i, j)}---------------');

        if (imageSrc.getPixel(i, j) == 0xff000000) {
          // print('-($i,$j)----${imageSrc.getPixel(i, j)}---------------');

          Particle particle = Particle(
              x: i * 1.0+ offsetX,
              y: j * 1.0+ offsetY,
                  vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
                  vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
                  ay: 0.1,
              size: 0.5,
              color: Colors.blue); //产生粒子---每个粒子拥有随机的一些属性信息

          pm.particles.add(particle);
        }
      }
    }
  }
}
