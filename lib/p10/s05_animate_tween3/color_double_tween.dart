import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/2
/// contact me by email 1981462002@qq.com
/// 说明:

class ColorDouble {
  final Color color;
  final double value;

  ColorDouble({this.color = Colors.blue, this.value = 0});
}

class ColorDoubleTween extends Tween<ColorDouble> {
  ColorDoubleTween({ColorDouble begin, ColorDouble end})
      : super(begin: begin, end: end);

  @override
  ColorDouble lerp(double t) => ColorDouble(
      color: Color.lerp(begin.color, end.color, t),
      value: (begin.value + (end.value - begin.value) * t));
}
