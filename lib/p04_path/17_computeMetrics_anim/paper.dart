import 'dart:ui';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  AnimationController ctrl;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(duration: Duration(seconds: 3), vsync: this)
      ..addListener(_render)..forward();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(progress: progress),
      ),
    );
  }

  void _render() {
    setState(() {
      progress = ctrl.value;
    });
  }

}

class PaperPainter extends CustomPainter {

  final double progress;

  PaperPainter({this.progress = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      Tangent tangent = pm.getTangentForOffset(pm.length * progress);

      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
    });

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => oldDelegate.progress!=progress;
}
