/// create by 张风捷特烈 on 2020/11/3
/// contact me by email 1981462002@qq.com
/// 说明: 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'handle_widget.dart';

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
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: _rotate,
             child:
                Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                ),
            ),
            HandleWidget(
            onMove: _onMove,
            ),
          ],
        ),
      ),
    );
  }

  void _onMove(double rotate, double distance) {
    setState(() {
      _rotate= rotate;
    });
  }
}
