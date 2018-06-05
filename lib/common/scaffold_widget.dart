import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  Widget child;
  Widget title;

  ScaffoldWidget({this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: title,
      ),
      body: child,
    );
  }
}
