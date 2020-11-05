import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'toly_wave_loading.dart';

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
      home: Scaffold(
        body:  Center(child: Wrap(
          spacing: 30,
          runSpacing: 30,
          children: List.generate(9, (v) => 0.1 * v+0.1)
              .map((e) => TolyWaveLoading(
            isOval: (e*10).toInt().isEven, // 是否椭圆裁切
            progress: e, // 进度
            waveHeight: 3, //波浪高
            color: [Colors.blue,Colors.red,Colors.green][(e*10).toInt()%3], //颜色
          )).toList(),
        )),
      ),
    );
  }
}
