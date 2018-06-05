import 'package:flutter/material.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/utils/style.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';

///蜂鸟转送
class Fengniao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DecoratedBg(
      child: new RatedPadding(
        padding: new EdgeInsets.fromLTRB(0.004, 0.0, 0.004, 0.0),
        child: new Text(
          "蜂鸟专送",
          style: new TextStyle(fontSize: Style.text.small, color: Colors.white),
        ),
      ),
    );
  }
}
