main(){

  List<int> li = [0,1,2,3,4];

  // for(int i =0;i<li.length;i++){
  //   if(li[i]==2) return;
  //   print(li[i]);
  // }

  li.forEach((e) {
    if(e==2) return;
    print(e);
  });

  // parserResults.forEach((SVGPathResult? result) {
  //   if(result==null) return;
  //
  // });
}