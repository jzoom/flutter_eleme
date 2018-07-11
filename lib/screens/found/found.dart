import 'package:flutter/material.dart';
import 'package:flutter_eleme/widgets/decorated_app_bar.dart';

class FoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(color: new Color(0xfff5f5f5),child: new Column(
    children: <Widget>[
        new DecoratedAppBar(),

    ])));
  }
}
