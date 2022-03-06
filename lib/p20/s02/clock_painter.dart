import 'package:flutter/cupertino.dart';

import 'clock_manage.dart';

/// create by 张风捷特烈 on 2020/11/8
/// contact me by email 1981462002@qq.com
/// 说明:

class ClockPainter extends CustomPainter {
  final ClockManage manage;

  ClockPainter({required this.manage}) : super(repaint: manage);

  Paint clockPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    manage.particles.where((e) => e!=null&&e.active).forEach((particle) {
      clockPaint..color = particle.color;
      canvas.drawCircle(
          Offset(particle.x, particle.y), particle.size, clockPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
