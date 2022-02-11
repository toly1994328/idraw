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

  final curvesMap = {
    "linear": Curves.linear,
    "decelerate": Curves.decelerate,
    "fastLinearToSlowEaseIn": Curves.fastLinearToSlowEaseIn,
    "ease": Curves.ease,
    "easeIn": Curves.easeIn,
    "easeInToLinear": Curves.easeInToLinear,
    "easeInSine": Curves.easeInSine,
    "easeInQuad": Curves.easeInCubic,
    "easeInCubic": Curves.easeInCubic,
    "easeInQuart": Curves.easeInQuart,
    "easeInQuint": Curves.easeInQuint,
    "easeInExpo": Curves.easeInExpo,
    "easeInCirc": Curves.easeInCirc,
    "easeInBack": Curves.easeInBack,
    "easeOut": Curves.easeOut,
    "linearToEaseOut": Curves.linearToEaseOut,
    "easeOutSine": Curves.easeOutSine,
    "easeOutQuad": Curves.easeOutQuad,
    "easeOutCubic": Curves.easeOutCubic,
    "easeOutQuart": Curves.easeOutQuart,
    "easeOutQuint": Curves.easeOutQuint,

    // "easeOutExpo": Curves.easeOutExpo,
    // "easeOutCirc": Curves.easeOutCirc,
    // "easeOutBack": Curves.easeOutBack,
    // "easeInOut": Curves.easeInOut,
    // "easeInOutSine": Curves.easeInOutSine,
    // "easeInOutQuad": Curves.easeInOutQuad,
    // "easeInOutCubic": Curves.easeInOutCubic,
    // "easeInOutQuart": Curves.easeInOutQuart,
    // "easeInOutQuint": Curves.easeInOutQuint,
    // "easeInOutExpo": Curves.easeInOutExpo,
    // "easeInOutCirc": Curves.easeInOutCirc,
    // "easeInOutBack": Curves.easeInOutBack,
    // "fastOutSlowIn": Curves.fastOutSlowIn,
    // "slowMiddle": Curves.slowMiddle,
    // "bounceIn": Curves.bounceIn,
    // "bounceOut": Curves.bounceOut,
    // "bounceInOut": Curves.bounceInOut,
    // "elasticIn": Curves.elasticIn,
    // "elasticInOut": Curves.elasticInOut,
    // "elasticOut": Curves.elasticOut,
  };

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
            child:
            Wrap(
              runSpacing: 10,
              children: curvesMap.keys.map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CurveBox(curve: curvesMap[e]!,),
                  SizedBox(height: 3,),
                  Text(e,style: TextStyle(fontSize: 10),)
                ],
              )).toList(),
            ),
          ),
        ));
  }
}