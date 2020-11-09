import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Particle {

  /// 粒子 x 位置
  double x;

  /// 粒子 y 位置
  double y;

  /// 粒子角度(弧度制)
  double a;

  /// 粒子水平速度
  double vx;

  /// 粒子垂直速度
  double vy;

  /// 距画布中心距离
  double dist;

  /// 到画布中心距离的百分比 (0-1).
  double distFrac;

  /// 粒子大小
  double size;

  /// 粒子生命长度 (0-1).
  double life;

  /// 粒子右侧粒子存货时间 (0-1).
  double lifeLeft;

  /// I粒子是否填充.
  bool isFilled;

  /// 粒子是否需要 "speed marks".
  bool isFlowing;

  /// 粒子颜色.
  Color color;

  /// 粒子描述
  int distribution;

  /// 粒子类型
  ParticleType type;

  Particle({
    this.x = 0,
    this.y = 0,
    this.a = 0,
    this.vx = 0,
    this.vy = 0,
    this.dist = 0,
    this.distFrac = 0,
    this.size = 0,
    this.life = 0,
    this.lifeLeft = 0,
    this.isFilled = false,
    this.isFlowing = false,
    this.color = Colors.black,
    this.distribution = 0,
    this.type = ParticleType.noise,
  });
}

enum ParticleType {
  hour,
  minute,
  noise,
}
