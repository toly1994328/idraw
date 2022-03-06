import 'dart:math';

import 'package:flutter/widgets.dart';

import 'palette.dart';
import 'particle.dart';
import 'utils/rnd.dart';

final Color transparent = Color.fromARGB(0, 0, 0, 0);

abstract class ClockFx with ChangeNotifier {
  /// 可用画板宽度
  double width = 0;

  /// 可用画板盖度
  double height = 0;

  /// 宽高最小值
  double sizeMin = 0;

  /// 画板中心
  Offset center = Offset.zero;

  /// 产生新粒子的区域
  Rect spawnArea = Rect.zero;

  /// 绘制时的颜色集
  Palette? palette;

  /// 粒子集合
  late List<Particle> particles;

  /// 最大粒子数
  int numParticles;

  /// Date and time used for rendering time-specific effects.
  DateTime time;

  ClockFx({
    required Size size,
    required this.time,
    this.numParticles = 5000,
  }) {
    this.time = time;

    particles = [];
    // growableList.length = 3;
    palette = Palette(components: [transparent, transparent]);
    setSize(size);
  }

  /// Initializes the particle effect by resetting all the particles and assigning a random color from the palette.
  void init() {
    if (palette == null) return;
    for (int i = 0; i < numParticles; i++) {
      var color = Rnd.getItem(palette!.components);
      particles[i] = Particle(color: color);
      resetParticle(i);
    }
  }

  /// Sets the palette used for coloring.
  void setPalette(Palette palette) {
    this.palette = palette;
    var colors = palette.components.sublist(1);
    var accentColor = colors[colors.length - 1];
    particles.where((p) => p != null).forEach((p) => p.color =
        p.type == ParticleType.noise ? Rnd.getItem(colors) : accentColor);
  }

  /// Sets the time used for time-specific effects.
  void setTime(DateTime time) {
    this.time = time;
  }

  /// Sets the canvas size and updates dependent values.
  void setSize(Size size) {
    width = size.width;
    height = size.height;
    sizeMin = min(width, height);
    center = Offset(width / 2, height / 2);
    spawnArea = Rect.fromLTRB(
      center.dx - sizeMin / 100,
      center.dy - sizeMin / 100,
      center.dx + sizeMin / 100,
      center.dy + sizeMin / 100,
    );
    init();
  }

  /// Resets a particle's values.
  Particle resetParticle(int i) {
    Particle p = particles[i];
    p.size = p.a = p.vx = p.vy = p.life = p.lifeLeft = 0;
    p.x = center.dx;
    p.y = center.dy;
    return p;
  }

  void tick(Duration duration) {
    notifyListeners();
  }
}
