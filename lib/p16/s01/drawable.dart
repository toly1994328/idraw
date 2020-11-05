import 'dart:ui';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class Drawable {
  void draw(Canvas canvas, Size size);
}

class Option {
  Title title;
  XAxis xAxis;
}

class Title {
  String text;
}

class XAxis {
  List<String> data;
}
class YAxis {
  List<String> data;
}

class Series {
  String name;
  String type;
  List<String> data;
}
