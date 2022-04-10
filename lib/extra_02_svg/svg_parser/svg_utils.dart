import 'dart:math';
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
    RegExp formatRegExp = RegExp(r'( *, *)|( +)');
    src = src.replaceAll('-', ' -').replaceAll(formatRegExp, ' ');

    RegExp regExp =
        RegExp(r'[M,H,V,L,C,Q,S,A,m,l,h,v,c,s,q,a]( ?-?((\d+\.\d+)|\d)([ ,])?)+|[Zz]');
    List<RegExpMatch> results = regExp.allMatches(src).toList();
    RegExp splitExp = RegExp(r' ');

    double lastX = 0;
    double lastY = 0;
    double sCtrl1X  = 0;
    double sCtrl1Y  = 0;
    results.forEach((RegExpMatch element) {
      String? op = element.group(0);
      if (op != null) {
        op = op.trim();
        if (op.startsWith("M")) {
          List<String> pos = op.substring(1).split(splitExp);
          double dx = num.parse(pos[0]).toDouble();
          double dy = num.parse(pos[1]).toDouble();
          path.moveTo(dx, dy);
          sCtrl1X = dx;
          sCtrl1Y = dy;

          lastX = dx;
          lastY = dy;
        }
        if (op.startsWith("m")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          double dx = num.parse(pos[0]).toDouble();
          double dy = num.parse(pos[1]).toDouble();
          path.relativeMoveTo(dx, dy);
          sCtrl1X = sCtrl1X+dx;
          sCtrl1Y = sCtrl1Y+dy;
          lastX = dx+lastX;
          lastY = dy+lastY;
        }
        if (op.startsWith("L")) {
          List<String> pos = op.substring(1).split(splitExp);
          for (int i = 0; i < pos.length; i += 2) {
            double dx = num.parse(pos[i]).toDouble();
            double dy = num.parse(pos[i + 1]).toDouble();
            path.lineTo(dx, dy);

            lastX = dx;
            lastY = dy;
          }
        }
        if (op.startsWith("l")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 2) {
            double dx = num.parse(pos[i]).toDouble();
            double dy = num.parse(pos[i + 1]).toDouble();
            path.relativeLineTo(dx, dy);
            sCtrl1X = sCtrl1X+dx;
            sCtrl1Y = sCtrl1Y+dy;
            lastX = dx+lastX;
            lastY = dy+lastY;
          }
        }
        if (op.startsWith("H")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i++) {
            double dx = num.parse(pos[i]).toDouble();
            double dy = lastY;
            path.lineTo(dx, dy);
            lastX = dx;
          }
        }
        if (op.startsWith("h")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i++) {
            double dx = num.parse(pos[i]).toDouble();
            path.relativeLineTo(dx, 0);
            sCtrl1X = sCtrl1X+dx;
            lastX = lastX + dx;
          }
        }
        if (op.startsWith("V")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i++) {
            double dx = lastX;
            double dy = num.parse(pos[i]).toDouble();
            path.lineTo(dx, dy);
            lastY = dy;
          }
        }
        if (op.startsWith("v")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i++) {
            double dy = num.parse(pos[i]).toDouble();
            path.relativeLineTo(0, dy);
            sCtrl1Y = sCtrl1Y+dy;
            lastY = lastY+dy;
          }
        }
        if (op.startsWith("C")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
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
            //(x + x0)/2 = x1  ==> x = 2*x1 - x0
            // (y + y0)/2 = y1  ==> y = 2*y1 - y0
            sCtrl1X = 2*p2x - p1x;
            sCtrl1Y = 2*p2y - p1y;
          }
        }
        if (op.startsWith("c")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 6) {
            double p0x = num.parse(pos[i]).toDouble();
            double p0y = num.parse(pos[i + 1]).toDouble();
            double p1x = num.parse(pos[i + 2]).toDouble();
            double p1y = num.parse(pos[i + 3]).toDouble();
            double p2x = num.parse(pos[i + 4]).toDouble();
            double p2y = num.parse(pos[i + 5]).toDouble();
            path.relativeCubicTo(p0x, p0y, p1x, p1y, p2x, p2y);

            sCtrl1X = 2*p2x - p1x+lastX;
            sCtrl1Y = 2*p2y - p1y+lastY;

            lastX = p2x+lastX;
            lastY = p2y+lastY;

          }
        }
        if (op.startsWith("S")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 4) {
            double p0x = sCtrl1X;
            double p0y = sCtrl1Y;
            double p1x = num.parse(pos[i + 0]).toDouble();
            double p1y = num.parse(pos[i + 1]).toDouble();
            double p2x = num.parse(pos[i + 2]).toDouble();
            double p2y = num.parse(pos[i + 3]).toDouble();
            path.cubicTo(p0x, p0y, p1x, p1y, p2x, p2y);
            lastX = p2x;
            lastY = p2y;
            //(x + x0)/2 = x1  ==> x = 2*x1 - x0
            // (y + y0)/2 = y1  ==> y = 2*y1 - y0
            sCtrl1X = 2*p2x - p1x;
            sCtrl1Y = 2*p2y - p1y;
          }
        }
        if (op.startsWith("s")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 4) {
            double p0x = sCtrl1X-lastX;
            double p0y = sCtrl1Y-lastY;
            double p1x = num.parse(pos[i + 0]).toDouble();
            double p1y = num.parse(pos[i + 1]).toDouble();
            double p2x = num.parse(pos[i + 2]).toDouble();
            double p2y = num.parse(pos[i + 3]).toDouble();
            path.relativeCubicTo(p0x, p0y, p1x, p1y, p2x, p2y);
            //(x + x0)/2 = x1  ==> x = 2*x1 - x0
            // (y + y0)/2 = y1  ==> y = 2*y1 - y0
            sCtrl1X = 2*p2x - p1x+lastX;
            sCtrl1Y = 2*p2y - p1y+lastY;

            lastX = p2x+lastX;
            lastY = p2y+lastY;

          }
        }
        if (op.startsWith("Q")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
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
        if (op.startsWith("q")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 4) {
            double p0x = num.parse(pos[i]).toDouble();
            double p0y = num.parse(pos[i + 1]).toDouble();
            double p1x = num.parse(pos[i + 2]).toDouble();
            double p1y = num.parse(pos[i + 3]).toDouble();
            path.relativeQuadraticBezierTo(p0x, p0y, p1x, p1y);

            lastX = p1x+lastX;
            lastY = p1y+lastY;
          }
        }
        if (op.startsWith("A")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 7) {
            double a = num.parse(pos[i + 0]).toDouble();
            double b = num.parse(pos[i + 1]).toDouble();
            double endX = num.parse(pos[i + 5]).toDouble();
            double endY = num.parse(pos[i + 6]).toDouble();
            double rotation = num.parse(pos[i + 2]).toDouble() * pi / 180;
            bool largeArc = num.parse(pos[i + 3]).toDouble() == 1;
            bool clockwise = num.parse(pos[i + 4]).toDouble() == 1;
            path.arcToPoint(Offset(endX, endY),
                radius: Radius.elliptical(a, b),
                rotation: rotation,
                largeArc: largeArc,
                clockwise: clockwise);

            lastX = endX;
            lastY = endY;
          }
        }
        if (op.startsWith("a")) {
          List<String> pos = op.substring(1).trim().split(splitExp);
          for (int i = 0; i < pos.length; i += 7) {
            double a = num.parse(pos[i + 0]).toDouble();
            double b = num.parse(pos[i + 1]).toDouble();
            double endX = num.parse(pos[i + 5]).toDouble();
            double endY = num.parse(pos[i + 6]).toDouble();
            double rotation = num.parse(pos[i + 2]).toDouble() * pi / 180;
            bool largeArc = num.parse(pos[i + 3]).toDouble() == 1;
            bool clockwise = num.parse(pos[i + 4]).toDouble() == 1;
            path.relativeArcToPoint(Offset(endX, endY),
                radius: Radius.elliptical(a, b),
                rotation: rotation,
                largeArc: largeArc,
                clockwise: clockwise);

            lastX = endX+lastX;
            lastY = endY+lastY;
          }

        }
        if (op.startsWith("Z")) {
          path.close();
        }
        if (op.startsWith("z")) {
          // lastX = 0;
          // lastY = 0;
          path.close();
          // path..moveTo(lastX, lastY);

        }
      }
    });
    return path;
  }

}
