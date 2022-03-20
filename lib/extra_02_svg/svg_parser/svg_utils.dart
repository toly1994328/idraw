import 'dart:ui';

import 'svg_parser.dart';

extension SetPaintBySVGPath on SVGPathResult{
  void setPaint(Paint paint){
    if (this.strokeColor != null) {
      paint..style = PaintingStyle.stroke;
      Color resultColor = Color(
          int.parse(this.strokeColor!.substring(1), radix: 16) + 0xFF000000);
      paint..color = resultColor;
    }
    if (this.strokeWidth != null) {
      paint..strokeWidth = num.parse(this.strokeWidth!).toDouble();
    }
    if (this.fillColor != null) {
      paint..style = PaintingStyle.fill;
      Color resultColor = Color(
          int.parse(this.fillColor!.substring(1), radix: 16) + 0xFF000000);
      paint..color = resultColor;
    }
  }
}

class SvgUtils {

  static Path convertFromSvgPath(String src) {
    Path path = Path();
    RegExp regExp = RegExp(r'[M,H,V,L,C,Q](((\d+\.\d+)|\d)([ ,])?)+|Z');
    List<RegExpMatch> results = regExp.allMatches(src).toList();

    double lastX = 0;
    double lastY = 0;
    results.forEach((RegExpMatch element) {
      String? op = element.group(0);
      if (op != null) {
        if (op.startsWith("M")) {
          List<String> pos = op.substring(1).split(RegExp(r'[, ]'));
          double dx = num.parse(pos[0]).toDouble();
          double dy = num.parse(pos[1]).toDouble();
          path.moveTo(dx, dy);
          lastX = dx;
          lastY = dy;
        }
        if (op.startsWith("L")) {
          List<String> pos = op.substring(1).split(RegExp(r'[, ]'));
          for (int i = 0; i < pos.length; i += 2) {
            double dx = num.parse(pos[i]).toDouble();
            double dy = num.parse(pos[i + 1]).toDouble();
            path.lineTo(dx, dy);
            lastX = dx;
            lastY = dy;
          }
        }
        if (op.startsWith("H")) {
          List<String> pos = op.substring(1).trim().split(RegExp(r'[, ]'));
          for (int i = 0; i < pos.length; i++) {
            double dx = num.parse(pos[i]).toDouble();
            double dy = lastY;
            path.lineTo(dx, dy);
            lastX = dx;
          }
        }
        if (op.startsWith("V")) {
          List<String> pos = op.substring(1).trim().split(RegExp(r'[, ]'));
          for (int i = 0; i < pos.length; i++) {
            double dx = lastX;
            double dy = num.parse(pos[i]).toDouble();
            path.lineTo(dx, dy);
            lastY = dy;
          }
        }
        if (op.startsWith("C")) {
          List<String> pos = op.substring(1).trim().split(RegExp(r'[, ]'));
          for (int i = 0; i < pos.length; i += 6) {
            double p0x = num.parse(pos[i]).toDouble();
            double p0y = num.parse(pos[i + 1]).toDouble();
            double p1x = num.parse(pos[i + 2]).toDouble();
            double p1y = num.parse(pos[i + 3]).toDouble();
            double p2x = num.parse(pos[i + 4]).toDouble();
            double p2y = num.parse(pos[i + 5]).toDouble();
            path.cubicTo(p0x, p0y, p1x, p1y, p2x, p2y);
            lastX = p2x;
            lastY = p2y;
          }
        }
        if (op.startsWith("Q")) {
          List<String> pos = op.substring(1).trim().split(RegExp(r'[, ]'));
          for (int i = 0; i < pos.length; i += 4) {
            double p0x = num.parse(pos[i]).toDouble();
            double p0y = num.parse(pos[i + 1]).toDouble();
            double p1x = num.parse(pos[i + 2]).toDouble();
            double p1y = num.parse(pos[i + 3]).toDouble();
            path.quadraticBezierTo(p0x, p0y, p1x, p1y);
            lastX = p1x;
            lastY = p1y;
          }
        }
        if (op.startsWith("Z")) {
          path.close();
        }
      }
    });
    return path;
  }

}
