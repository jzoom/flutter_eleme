///
///
///这里用来创建下划线的DecoratedBox
///

import 'package:flutter/material.dart';

/// 分割线
Widget bottomDivider(BuildContext context, Widget child) {
  return new DecoratedBox(
      decoration: new BoxDecoration(
          border: new Border(bottom: Divider.createBorderSide(context))),
      child: child);
}

/// 分割线
Widget rightDivider(BuildContext context, Widget child){
  return new DecoratedBox(
      decoration: new BoxDecoration(
          border: new Border(right: Divider.createBorderSide(context))),
      child: child);
}



///渐变头部
class DecoratedBg extends StatelessWidget {
  final Widget child;


  final int start;
  final int end;

  DecoratedBg({Key key,this.child,int start,int end})
      :start = start ?? 0xff00aaff,
  end = end ?? 0xff0085ff,
      super(key:key);

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: <Color>[new Color(start), new Color(end)]),
      ),
      child: child,
    );
  }
}
