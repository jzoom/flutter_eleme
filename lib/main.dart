import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_eleme/empty_app_bar.dart';
import 'package:flutter_eleme/screens/home/home.dart';
import 'package:flutter_eleme/utils/caster.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/utils/style.dart';


void main() {
  //初始化类型转化
  Caster.init();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        textTheme: new TextTheme(
            body1: new TextStyle(
                color: Style.text.black6, fontSize: Style.text.body1)),
        primaryColor: Style.color.primaryColor,
        primarySwatch: Colors.blue,
      ),
      home: new _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<_HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Layout.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new EmptyAppBar(),
      primary: false,
      body: new SafeArea(child: new HomePage()),
    );
  }
}
