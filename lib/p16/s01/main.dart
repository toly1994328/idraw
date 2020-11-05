/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明: 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chart.dart';

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  Center(child: ICharts()),
      ),
    );
  }
}
