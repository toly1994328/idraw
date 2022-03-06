import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'particle.dart';
import 'res.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明:

class BgManage with ChangeNotifier {
  late List<Particle> particles;
  late DateTime datetime; // 时间
  Random random = Random();

  /// 粒子列表
  int numParticles;

  /// 最大粒子数
  Size size; // 尺寸

  BgManage({required this.size, this.numParticles = 500}) {
    particles = [];
    datetime = DateTime.now();
  }

  checkParticles(DateTime now) {
    //判断当前时间是否改变,再将点位放到集合中
    if ((datetime.hour ~/ 10) != (now.hour ~/ 10)) {
      collectDigit(target: datetime.hour ~/ 10, offsetRate: 0);
    }
    if ((datetime.hour % 10) != (now.hour % 10)) {
      collectDigit(target: datetime.hour % 10, offsetRate: 1);
    }
    if ((datetime.minute ~/ 10) != (now.minute ~/ 10)) {
      collectDigit(target: datetime.minute ~/ 10, offsetRate: 2.5);
    }
    if ((datetime.minute % 10) != (now.minute % 10)) {
      collectDigit(target: datetime.minute % 10, offsetRate: 3.5);
    }
    if ((datetime.second ~/ 10) != (now.second ~/ 10)) {
      collectDigit(target: datetime.second ~/ 10, offsetRate: 5);
    }
    if ((datetime.second % 10) != (now.second % 10)) {
      collectDigit(target: datetime.second % 10, offsetRate: 6);
      datetime = now;
    }
  }

  double _radius = 4;

  void collectDigit({int target = 0, double offsetRate = 0}) {
    if (target > 10) {
      return;
    }

    double space = _radius * 2;
    double offSetX =
        (digits[target][0].length * 2 * (_radius + 1) + space) * offsetRate;

    for (int i = 0; i < digits[target].length; i++) {
      for (int j = 0; j < digits[target][j].length; j++) {
        if (digits[target][i][j] == 1) {
          double rX = j * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心横坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心纵坐标
          Particle particle = Particle(
              x: rX + offSetX,
              y: rY,
              size: _radius,
              color: randomColor(),
              active: true,
              vx: 2.5 * random.nextDouble() * pow(-1, random.nextInt(20)),
              vy: 2 * random.nextDouble() + 1);
          particles.add(particle);
        }
      }
    }
  }

  Color randomColor({
    int limitA = 120,
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var a = limitA + random.nextInt(256 - limitA); //透明度值
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(a, r, g, b); //生成argb模式的颜色
  }

  void tick(DateTime now) {
    checkParticles(now);

    for (int i = 0; i < particles.length; i++) {
      doUpdate(particles[i]);
    }
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vy += p.ay; // y加速度变化
    p.vx += p.ax; // x加速度变化
    p.x += p.vx;
    p.y += p.vy;

    if (p.x > size.width) {
      p.x = size.width;
      p.vx = -p.vx;
    }

    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }

    if (p.y > size.height) {
      particles.remove(p);
    }
  }
}
