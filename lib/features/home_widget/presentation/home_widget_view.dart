import 'package:flutter/material.dart';
import 'package:home_widget_4/features/home_widget/controller/home_widget_controller.dart';

class HomeWidgetView extends StatefulWidget {
  const HomeWidgetView({super.key});

  @override
  State<HomeWidgetView> createState() => _HomeWidgetViewState();
}

class _HomeWidgetViewState extends State<HomeWidgetView> {
  @override
  void initState() {
    HomeWidgetController.sendDataToHomeWidget('this is a message from flutter app');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Home Widget')),
        body: SingleChildScrollView(child: Column(children: [])),
      ),
    );
  }
}
