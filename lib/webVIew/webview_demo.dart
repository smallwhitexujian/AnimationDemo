import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

const htmlString = '''
<!DOCTYPE html>
<html>
  <head>
    <title>JavaScript to Flutter communication</title>
  </head>
  <body>
    <h1>JavaScript to Flutter communication</h1>
    <button onclick="sendMessageToFlutter()">Send Message to Flutter</button>
    <p id="messageFromFlutter"></p>

    <script>
      // Function to send a message to Flutter
      function sendMessageToFlutter(msg) {
        var message = 'Hello from JavaScript!';
        alert(msg);
        flutterChannel.postMessage(message);
      }

      // Function to receive a message from Flutter
      function receiveFromFlutter(message) {
        var messageElement = document.getElementById('messageFromFlutter');
        messageElement.innerHTML = message;
      }

      window.appJS.xxx
       function flutterCallJsMethod(message){
        alert(message);
        return "我是JS返回的Result";
      }

      function flutterCallJsMethodNoResult(message){
        alert(message);
      }
    </script>
  </body>
</html>

''';

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
  var params = "Hello from Flutter";
  List<Widget> widgetList = [];
  String url = "";
  @override
  void initState() {
    controller = WebViewController()
      ..setBackgroundColor(Color.fromARGB(2, 0, 0, 0))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)

      ///JS调用原生的方法无返回值
      ..addJavaScriptChannel('flutterChannel', onMessageReceived: (message) {
        String data = message.message;
        log('Received message from JavaScript: $data');
        // controller?.runJavaScript("sendMessageToFlutter('洪恒强')");

        ///调用有返回值JS方法，并打印结果
        controller
            ?.runJavaScriptReturningResult("flutterCallJsMethod('$params')")
            .then((value) {
          log("=-=======>$value");
        });

        ///调用无返回值JS方法
        controller?.runJavaScript("flutterCallJsMethodNoResult($params)");
      })
      ..loadHtmlString(htmlString);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _incrementCounter() async {
    // rootBundle.loadString('assets/index.html').then((value) {
    //   setState(() {
    //     url = Uri.dataFromString(
    //       value,
    //       mimeType: 'text/html',
    //       encoding: Encoding.getByName('utf-8'),
    //     ).toString();
    //   });
    // }); // 替换为你的前端页面文件路径
  }

  WebViewController? controller;

  ///展示webview
  showWebview() {
    return (WebViewWidget(controller: WebViewController()));
  }

  String callFlutterMethod(String data) {
    print('Calling Flutter method with data: $data');
    return 'Hello from Flutter!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("web"),
      ),
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            color: Color.fromARGB(255, 60, 87, 101),
          ),
          if (controller != null) WebViewWidget(controller: controller!),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
