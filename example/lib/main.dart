import 'package:demo_animation/audio_all_mic_gift.dart';
import 'package:demo_animation/tools/random_screen_offset.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> widgetList = [];
  bool isOnClick = false;
  void _incrementCounter() async {
    if (!isOnClick) {
      isOnClick = true;
      for (int i = 0; i < 100000; i++) {
        await Future.delayed(const Duration(milliseconds: 150)); // 模拟异步操作
        setState(() {
          widgetList.add(AudioAllMicGift(
            endOffset:
                RandomScreenOffset.generateRandomScreenCoordinates(context),
            // childWidget: const Image(
            // image: AssetImage("images/xiayu.gif"), width: 100.0),
            childWidget: const Icon(Icons.accessibility),
          ));
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
