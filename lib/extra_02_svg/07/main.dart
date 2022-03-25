import 'package:flutter/material.dart';
import 'package:idraw/extra_02_svg/svg_parser/svg_utils.dart';

import '../svg_parser/svg_parser.dart';

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
            size: Size(128, 128),
            painter: SVGTestPainter(),
          ),
        ),
      ),
    );
  }
}

class SVGTestPainter extends CustomPainter {
  final SVGParser svgParser = SVGParser();

  Paint mainPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    String src1 =
    """<svg width="50" height="50" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M28,2 L43,2 12,32 4,25" fill="#3AD0FF" />
    <path d="M16,36 L30,48 44,48 23,29" fill="#00559E" />
    <path d="M16,36 L28,24 42,24 24,43" fill="#3AD0FF" />
</svg>
""";

    String src = """
<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M0,0 H128 V128 H0" fill="#FFFFFF" />
    
    <path d="M30,50 a30 40 0 1 1 50 80" stroke="#7E4FFF" stroke-width="2"/>
    
    <path d="M50,50 l30 40 h-20 v30 h-10 L10 60" stroke="#7E4FFF" stroke-width="2"/>
</svg>
""";

    List<SVGPathResult?> parserResults = svgParser.parser(src);
    parserResults.forEach((SVGPathResult? result) {
      if (result == null) return;
      if (result.path != null) {
        Path path = SvgUtils.convertFromSvgPath(result.path!);
        result.setPaint(mainPaint);
        canvas.drawPath(path, mainPaint);
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
