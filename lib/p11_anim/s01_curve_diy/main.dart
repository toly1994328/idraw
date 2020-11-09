import 'dart:math';

import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020/11/1
/// contact me by email 1981462002@qq.com
/// 说明:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'curve_box.dart';

void main() {
  // 确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏显示
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: CurveBox(curve: Cubic(1, -0.06, 0.1, 1.2),),
          ),
        ));
  }
}