main() {
  String src = "M50,50 l30 40 h-20 v30 h-10 L10 60";

  // RegExp regExp = RegExp(r'(?<=(fill="))(.*)(?=")');
  RegExp regExp = RegExp(r'( *, *)|( +)');
  String formatStr1 = src.replaceAll('-', ' -');

  String formatStr = src.replaceAll('-', ' -').replaceAll(regExp, ' ');

  RegExp regExp2 =
      RegExp(r'[M,H,V,L,C,Q,A,l,h,v,c,q,a]( ?-?((\d+\.\d+)|\d)([ ,])?)+|[Zz]');
  List<RegExpMatch> results = regExp2.allMatches(src).toList();
  results.forEach((RegExpMatch element) {
    String op = element.group(0) ?? '';
    print(op);
    // print(op.trim().substring(1).split(RegExp(r'( )')));
  });
  // print(formatStr);
}
