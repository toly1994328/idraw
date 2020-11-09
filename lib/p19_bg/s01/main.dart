/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明: 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'world.dart';

void main() {
  // // 确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  // //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // //全屏显示
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  Builder(
          builder:(ctx)=> Center(child: World(
            size: MediaQuery.of(ctx).size ,
          )),
        ),
      ),
    );
  }
}
