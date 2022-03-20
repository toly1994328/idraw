import 'package:xml/xml.dart';

class SVGPathResult {
  final String? path;
  final String? fillColor;
  final String? strokeColor;
  final String? strokeWidth;

  SVGPathResult({
    required this.path,
    this.fillColor,
    this.strokeColor,
    this.strokeWidth,
  });

  @override
  String toString() {
    return 'SVGPathResult{path: $path, fillColor: $fillColor, strokeColor: $strokeColor, strokeWidth: $strokeWidth}';
  }
}

class SVGParser {

  List<SVGPathResult?> parser(String src) {
    List<SVGPathResult?> result = [];
    final XmlDocument document = XmlDocument.parse(src);
    XmlElement? root = document.getElement('svg');
    if (root == null) return result;
    List<XmlElement> pathNodes = root.findAllElements('path').toList();
    pathNodes.forEach((pathNode) {
      String? pathStr = pathNode.getAttribute('d');
      String? fillColor = pathNode.getAttribute('fill');
      String? strokeColor = pathNode.getAttribute('stroke');
      String? strokeWidth = pathNode.getAttribute('stroke-width');
      result.add(SVGPathResult(
        path: pathStr,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
      ));
    });
    return result;
  }
}
