import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'particle.dart';
import 'res.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明:

class ClockManage with ChangeNotifier {
  late List<Particle> particles;
  late DateTime datetime; // 时间

  /// 粒子列表
  int numParticles;

  /// 最大粒子数
  Size size; // 尺寸

  ClockManage({this.size= Size.zero, this.numParticles = 500}) {
    particles = [];
    datetime = DateTime.now();
  }

  collectParticles(DateTime datetime) {
    count = 0;
    particles.forEach((Particle element) {
      if(element!=null){
        element.active = false;
      }
    });

    collectDigit(target: datetime.hour ~/ 10, offsetRate: 0);
    collectDigit(target: datetime.hour % 10, offsetRate: 1);
    collectDigit(target: 10, offsetRate: 3.2);
    collectDigit(target: datetime.minute ~/ 10, offsetRate: 2.5);
    collectDigit(target: datetime.minute % 10, offsetRate: 3.5);
    collectDigit(target: 10, offsetRate: 7.25);
    collectDigit(target: datetime.second ~/ 10, offsetRate: 5);
    collectDigit(target: datetime.second % 10, offsetRate: 6);
  }

  int count = 0;
  double _radius = 4;

  void collectDigit({int target = 0, double offsetRate = 0}) {
    if (target > 10 && count > numParticles) {
      return;
    }

    double space = _radius * 2;
    double offSetX = (digits[target][0].length * 2 * (_radius + 1) + space) *
        offsetRate;

    for (int i = 0; i < digits[target].length; i++) {
      for (int j = 0; j < digits[target][j].length; j++) {
        if (digits[target][i][j] == 1) {
          double rX = j * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心横坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心纵坐标
          particles[count] = Particle(x: rX + offSetX,
              y: rY, size: _radius, color: Colors.blue,
              active: true);
          count++;
        }
      }
    }
  }

  void tick(DateTime now) {
    collectParticles(now);
    notifyListeners();
  }

  void doUpdate(Particle p, DateTime datetime) {

  }
}
