main(){
  String src ="M30,50 A30 40 0 1 1 50 80";

  // RegExp regExp = RegExp(r'(?<=(fill="))(.*)(?=")');
  RegExp regExp = RegExp(r'[M,H,V,L,C,Q,A,l,h,v,c,q,a]((-?(\d+\.\d+)|\d)([ ,])?)+|[Zz]');

 // List<RegExpMatch> matchResults = regExp.allMatches(src).toList();
 //
 //  matchResults.forEach((Match match) {
 //    print(match.group(0));
 //  });

  String l0 = "A30 40 0 1 1 50 80";
  RegExp exp = RegExp(r'(?=(([,-])|( )+))');
  List<String> pos = l0.substring(1).split(exp).map((e) => e.trim()).toList();
  // List<RegExpMatch> matchResults = exp.allMatches(l0).toList();

  print(pos);
}