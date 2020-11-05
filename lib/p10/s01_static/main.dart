import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020/11/1
/// contact me by email 1981462002@qq.com
/// 说明:

import 'package:flutter/material.dart';

import 'pic_man.dart';

void main() => runApp(MyApp());

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
            body: Padding(
          padding: const EdgeInsets.only(top: 58.0, left: 20),
          child: Center(
            child: Wrap(spacing: 20, runSpacing: 20, children: buildChildren()),
          ),
        )));
  }

  List<Widget> buildChildren() =>
      List<Widget>.generate(6,
      (index) => PicMan(
            color: Colors.lightBlue,
            angle: (1 + index) * 6.0, // 背景
          ));
}
