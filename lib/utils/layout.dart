import 'package:flutter/material.dart';

class Layout {
  ///这个值必须在第一个屏幕就定义好
  static double width;

  static void init(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);

    width = data.size.width;
  }

  /// 获取宽度的比例值
  /// 当前屏幕宽度600,
  /// Layout.rate( 0.1 ) = 60
  /// 用于适配各种宽度的屏幕，使得视图看起来效果一样
  /// 用于各种尺寸:  如
  /// Padding SizedBox Container
  ///
  ///
  static double rate(double value) {
    if (value == null) return null;
    return width * value;
  }
}

class RatedSizedBox extends StatelessWidget {
  final Widget child;

  final double width;

  final double height;

  const RatedSizedBox({Key key, this.width, this.height, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: Layout.rate(width),
      height: Layout.rate(height),
      child: child,
    );
  }
}

/// 这个控件用来替换Padding，每一个值都是一个宽度比例，以便于适配大屏幕、小屏幕
class RatedPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  RatedPadding({@required this.padding, this.child, Key key})
      : assert(padding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.fromLTRB(
            Layout.rate(padding.left),
            Layout.rate(padding.top),
            Layout.rate(padding.right),
            Layout.rate(padding.bottom)),
        child: child);
  }
}
