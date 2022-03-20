import 'package:flutter/material.dart';

import 'svg_parser.dart';
import 'dart:ui' as ui;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CustomPaint(
            size: Size(137, 28),
            painter: SVGTestPainter(),
          ),
        ),
      ),
    );
  }
}

//
// class SVGPathResult{
//   final Color color;
//   final Path path;
//
//   SVGPathResult({required this.color, required this.path});
// }

class SVGTestPainter extends CustomPainter {
  final SVGParser svgParser = SVGParser();

  // RegExp regExp = RegExp(r'[M,H,V,L]((\d+\.\d+)( )?)+');
  // List<RegExpMatch> results = regExp.allMatches(src).toList();
  // results.forEach((element) {
  // print(element.group(0));
  // });

  //<path d="M17.5865 17.3955H17.5902L28.5163 8.77432L25.5528 6.39453L17.5902 12.6808H17.5865L17.5828 12.6845L9.62018 6.40201L6.6604 8.78181L17.5828 17.3992L17.5865 17.3955Z" fill="#1E80FF"/>
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.grey.withOpacity(0.3);
    // canvas.drawRect(Offset.zero & size, paint);
    String src1 =
        """<svg width="50" height="50" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M28,2 L43,2 12,32 4,25" fill="#3AD0FF" />
    <path d="M16,36 L30,48 44,48 23,29" fill="#00559E" />
    <path d="M16,36 L28,24 42,24 24,43" fill="#3AD0FF" />
</svg>
""";    String src3 =
        """
<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
    "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg t="1646998306167" class="icon" viewBox="0 0 1024 1024" version="1.1"
    xmlns="http://www.w3.org/2000/svg" p-id="2700" width="128" height="128">
    <defs>
        <style type="text/css"></style>
    </defs>
    <path
        d="M304.064985 471.748923l201.885538-88.186092 203.776 88.182154-17.636431 70.561477v176.368246l-176.376123 47.092184-194.008615-47.092184v-176.368246z"
        fill="#96DD5D" p-id="2701"></path>
    <path
        d="M181.169231 464.738462v358.4l327.061661 78.76923L834.953846 821.937231v-365.075693L787.692308 480.492308V783.753846l-279.461416 70.892308L228.430769 783.753846v-311.138461z"
        fill="#000000" p-id="2702"></path>
    <path
        d="M551.384615 169.353846l417.476923 181.169231c38.959262 24.000985 37.643815 46.316308-3.938461 66.953846l-456.861539 185.107692-445.046153-181.16923c-55.0912-21.137723-56.398769-47.391508-3.938462-78.769231l409.6-173.292308c28.408123-11.945354 55.977354-11.945354 82.707692 0z m-6.293661 47.643569c-22.724923-10.149415-46.158769-10.149415-70.301539 0l-348.16 143.36c-46.993723 10.791385-45.879138 25.237662 3.347693 43.327016l378.28923 146.116923 388.332308-149.468554c39.569723-8.644923 40.684308-19.739569 3.347692-33.28l-354.7136-149.996308z"
        fill="#000000" p-id="2703"></path>
    <path
        d="M47.261538 370.215385a23.630769 23.630769 0 0 1 23.63077 23.630769v291.446154a23.630769 23.630769 0 0 1-47.261539 0v-291.446154a23.630769 23.630769 0 0 1 23.630769-23.630769z"
        fill="#000000" p-id="2704"></path>
</svg>
""";
    String src = """
<svg width="137" height="28" viewBox="0 0 137 28" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M17.5865 17.3955H17.5902L28.5163 8.77432L25.5528 6.39453L17.5902 12.6808H17.5865L17.5828 12.6845L9.62018 6.40201L6.6604 8.78181L17.5828 17.3992L17.5865 17.3955Z" fill="#1E80FF"/>
<path d="M17.5872 6.77268L21.823 3.40505L17.5872 0.00748237L17.5835 0L13.3552 3.39757L17.5835 6.76894L17.5872 6.77268Z" fill="#1E80FF"/>
<path d="M17.5865 23.2854L17.5828 23.2891L2.95977 11.7531L0 14.1291L0.284376 14.3574L17.5865 28L28.5238 19.3752L35.1768 14.1254L32.2133 11.7456L17.5865 23.2854Z" fill="#1E80FF"/>
<path d="M133.287 18.4172H131.162L129.923 23.0758H126.825V16.7559H135.364V14.7315H126.825V11.1469H133.074V9.12256H118.454V11.1469H124.703V14.7315H116.164V16.7559H124.703V23.0758H121.601L120.363 18.4172H118.237L119.487 23.0758H115.543V25.1001H135.985V23.0758H132.041L133.287 18.4172Z" fill="#323232"/>
<path d="M130.522 3.3151L130.2 2.94092H121.321L120.999 3.3151C119.298 5.2467 117.378 6.97337 115.278 8.46009V10.9522C116.206 10.3573 120.183 7.72295 122.327 4.98768H129.235C131.375 7.72295 135.356 10.3573 136.284 10.9522V8.46009C134.169 6.97586 132.235 5.2491 130.522 3.3151Z" fill="#323232"/>
<path d="M94.9037 8.53127H96.494V6.50323H94.9037V2.88867H92.9056V6.50323H91.3303V8.53127H92.9094V14.7914L91.3303 15.3377V17.5828L92.9094 17.0365V20.7371C92.8414 22.2391 92.5579 23.7236 92.0674 25.145H94.1629C94.6112 23.7165 94.863 22.2335 94.9112 20.7371V16.3442L96.5053 15.7904V13.5229L94.9112 14.0767L94.9037 8.53127Z" fill="#323232"/>
<path d="M99.1875 2.88867H97.6608V20.7446C97.6727 22.2359 97.4852 23.7221 97.1033 25.1637H99.1875C99.5206 23.7145 99.6851 22.2316 99.6776 20.7446V9.77357H112.321V2.88867H99.1875ZM110.308 7.75303H99.6851V4.91671H110.304L110.308 7.75303Z" fill="#323232"/>
<path d="M110.305 23.405H107.566V17.6838H110.021H110.702H111.91V11.8166H110.021V15.9363H107.566V11.1431H105.676V15.9363H103.27V11.8166H101.381V17.6838H102.298H103.27H105.676V23.405H102.967V19.173H101.074V25.1524H102.286H102.967H110.305H110.683H112.195V19.173H110.305V23.405Z" fill="#323232"/>
<path d="M53.0024 2.91846V4.83801L56.5908 6.11397L53.0024 7.38618V9.30573L59.2887 7.07187L65.5749 9.30573V7.38618L61.9865 6.11397L65.5749 4.83801V2.91846L59.2887 5.15232L53.0024 2.91846Z" fill="#323232"/>
<path d="M79.9508 11.697H88.5944V9.47813H79.9508V2.80273H77.5299V9.47813H68.8863V11.697H77.5299V22.9823H67.76V25.2012H89.7207V22.9823H79.9508V11.697Z" fill="#323232"/>
<path d="M48.9461 5.39227L52.2913 5.18272V3.24072L43.6813 3.78328V5.72529L47.0265 5.512V8.50545H43.5803V10.4213H47.0265V25.164H48.9461V10.4213H52.3923V8.50545H48.9461V5.39227Z" fill="#323232"/>
<path d="M57.6539 9.01025H55.6595L55.1768 10.3648H52.9991V12.2357H54.5145L52.55 17.7662H53.8821V24.1534H55.7007V16.8457H58.6642V25.1787H60.5837V16.8457H63.4612V21.059C63.4534 22.1374 63.181 23.1974 62.6679 24.146H64.7147C65.1423 23.173 65.3627 22.1217 65.362 21.059V15.6932V15.1282H60.5837V13.2572H58.6642V15.1282H55.4836L56.5313 12.2245H65.594V10.3536H57.1749L57.6539 9.01025Z" fill="#323232"/>
<path d="M43.562 24.6246H45.4591L46.2786 11.4272H44.3815L43.562 24.6246Z" fill="#323232"/>
<path d="M49.7849 11.4272L50.3499 23.2963H52.247L51.682 11.4272H49.7849Z" fill="#323232"/>
</svg>
""";

    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    Paint mainPaint = Paint();

    // mainPaint.shader = ui.Gradient.linear(
    //     Offset(0, 0), Offset(137, 0), colors, pos, TileMode.clamp);
    mainPaint.maskFilter=MaskFilter.blur(BlurStyle.inner, 10);
    List<SVGPathResult?> parserResults = svgParser.parser(src);
    parserResults.forEach((SVGPathResult? result) {
      if (result == null) return;
      if (result.path != null) {
        Path path = formPathFromSvgPath(result.path!);
        setPainterByParserResult(result, mainPaint);
        canvas.drawPath(path, mainPaint..style=PaintingStyle.fill );
        canvas.drawPath(path, mainPaint..style=PaintingStyle.stroke );
      }
    });
  }

  void setPainterByParserResult(SVGPathResult result, Paint paint) {
    if (result.strokeColor != null) {
      paint..style = PaintingStyle.stroke;
      Color resultColor = Color(
          int.parse(result.strokeColor!.substring(1), radix: 16) + 0xFF000000);
      paint..color = resultColor;
    }
    if (result.strokeWidth != null) {
      paint..strokeWidth = num.parse(result.strokeWidth!).toDouble();
    }
    if (result.fillColor != null) {
      paint..style = PaintingStyle.fill;
      Color resultColor = Color(
          int.parse(result.fillColor!.substring(1), radix: 16) + 0xFF000000);
      paint..color = resultColor;
    }
  }

  Path formPathFromSvgPath(String src) {
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
      // print(element.group(0));
    });
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
