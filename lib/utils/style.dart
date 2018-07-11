import 'package:flutter/material.dart';

class Style {
  static StyleText text = new StyleText();

  static StyleColor color = new StyleColor();
}

class StyleColor {
  /// 主要颜色
  final Color primaryColor = new Color(0xff0089dc);

  /// font颜色
  final Color fontColor = Style.text.black6;
}

class StyleText {
  /// 最小文字，如下面的tab等
  final double small = 10.0;

  /// 默认body文字
  final double body1 = 11.0;

  final double body2 = 12.0;

  /// 菜单
  final double menu = 14.0;

  /// 菜单
  final double mine = 16.0;

  /// 标题
  final double title = 17.0;

  final double number = 22.0;

  /// 文字颜色
  final Color black6 = new Color(0xff666666);

  /// 文字颜色
  final Color black3 = new Color(0xff333333);

  final Color black2 = new Color(0xff222222);
}
