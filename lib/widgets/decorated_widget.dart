///
///
///这里用来创建下划线的DecoratedBox
///

import 'package:flutter/material.dart';

/// 分割线
Widget createDivider(BuildContext context, Widget child) {
  return new DecoratedBox(
      decoration: new BoxDecoration(
          border: new Border(bottom: Divider.createBorderSide(context))),
      child: child);
}

///渐变头部
class DecoratedBg extends StatelessWidget {
  Widget child;

  DecoratedBg({this.child});

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: <Color>[new Color(0xff00aaff), new Color(0xff0085ff)]),
      ),
      child: child,
    );
  }
}
