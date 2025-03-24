import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  runApp(const MyApp());
}

/*
flutter clean && rm -rf ios/Pods ios/Podfile.lock && flutter pub get && cd ios && pod install && cd .. && flutter build ios --config-only
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
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
  int _counter = 0;
  final String appGroupId = 'group.gaztec4widget';
  final String androidWidgetName = 'HomeWidget';
  final String iosWidgetName = 'HomeWidget';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    String title = "The counter value is $_counter";
    HomeWidget.saveWidgetData('headline_title', title);
    HomeWidget.updateWidget(iOSName: iosWidgetName, androidName: androidWidgetName);
  }

  @override
  void initState() {
    HomeWidget.setAppGroupId(appGroupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
