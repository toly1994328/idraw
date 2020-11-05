import 'package:flutter/material.dart';

import '../coordinate.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:
class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint( // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}


class PaperPainter extends CustomPainter {

  final Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo( 60,-10,)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    paint
      ..style = PaintingStyle.stroke..color=Colors.green
      ..strokeWidth = 2;
    path
      ..relativeMoveTo(-200, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo( 60,-10,)..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}