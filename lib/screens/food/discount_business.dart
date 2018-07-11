import 'package:flutter/material.dart';
import 'package:flutter_eleme/services/food_service.dart';
import 'package:flutter_eleme/utils/layout.dart';

/// 优惠商家  ，列表头部的轮播 tab页面
class DiscountBusiness extends StatefulWidget {
  final List<List<DiscountBusinessInfo>> data;

  DiscountBusiness({this.data});

  @override
  State<StatefulWidget> createState() {
    return new _DiscountBusinessState();
  }
}

const double kSpacing = 6.0;

class _DiscountBusinessState extends State<DiscountBusiness>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  /// 优惠商家信息，一个分页
  Widget _buildDiscountBusinessPage(List<DiscountBusinessInfo> list) {
    return new Padding(
        child: new Wrap(
            runSpacing: kSpacing,
            children: list.map((DiscountBusinessInfo info) {
              return new RatedSizedBox(
                width: 0.2,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RatedSizedBox(
                        width: 0.12,
                        height: 0.12,
                        child: new Image.network(info.img)),
                    new Padding(
                      padding: new EdgeInsets.only(top: kSpacing),
                      child: new Text(info.name),
                    )
                  ],
                ),
              );
            }).toList()),
        padding: new EdgeInsets.fromLTRB(0.0, kSpacing, 0.0, kSpacing));
  }

  @override
  void initState() {
    _controller = new TabController(length: widget.data.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<List<DiscountBusinessInfo>> _discountBusiness = widget.data;
    return new ConstrainedBox(
      constraints: new BoxConstraints.loose(new Size(Layout.width, 250.0)),
      child: new TabBarView(
          controller: _controller,
          children: _discountBusiness.map(_buildDiscountBusinessPage).toList()),
    );
  }
}
