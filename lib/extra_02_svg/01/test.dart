main(){
  String src = """
 <path d="M17.5872 6.77268L21.823 3.40505L17.5872 0.00748237L17.5835 0L13.3552 3.39757L17.5835 6.76894L17.5872 6.77268Z" fill="#1E80FF"/>

  """;
  // String src = """
  // """;

  RegExp regExp = RegExp(r'(?<=(fill="))(.*)(?=")');
  List<RegExpMatch> results = regExp.allMatches(src).toList();
  results.forEach((element) {
    // String? colorStr = element.namedGroup('color');
    // print(colorStr);

    print(element.group(0));
  });

  // String op = 'M0,0';
  // print(op.substring(1).split(RegExp(r'[, ]')));
}