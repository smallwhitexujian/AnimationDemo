import 'package:demo_animation/audio_all_mic_gift.dart';
import 'package:demo_animation/tools/random_screen_offset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintBaselinesEnabled = true;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<StatefulWidget> createState() {
    return DemoState();
  }
}

class DemoState extends State<StatefulWidget> {
  List<Widget> widgetList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _incrementCounter() async {
    // ignore: unused_local_variable
    // for (int i = 0; i < 100000; i++) {
    //   await Future.delayed(Duration(milliseconds: 150)); // 模拟异步操作
    //   setState(() {
    //     widgetList.add(AnimationFulWidget(
    //       endOffset: generateRandomScreenCoordinates(context),
    //       durationTime: 3000,
    //     ));
    //   });
    // }
    setState(() {
      widgetList.add(AudioAllMicGift(
        endOffset: RandomScreenOffset.generateRandomScreenCoordinates(context),
        durationTime: 3000,
        childWidget: const Icon(Icons.handshake),
        animationStateCallback: (status) {
          print("000000打印状态$status 00<");
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("坐标动画"),
      ),
      body: Center(
        child: Stack(alignment: Alignment.center, children: widgetList),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
