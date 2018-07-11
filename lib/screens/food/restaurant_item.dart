import 'package:flutter/material.dart';
import 'package:flutter_eleme/services/food_service.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/utils/style.dart';
import 'package:flutter_eleme/widgets/fengniao.dart';
import 'package:flutter_eleme/widgets/rateing_bar.dart';

/// 活动
class _Activities extends StatefulWidget {
  final List<ActivityInfo> data;

  _Activities(this.data);

  @override
  State<StatefulWidget> createState() {
    return new _ActivitiesState();
  }
}

class _ActivityItem extends StatelessWidget {
  final ActivityInfo data;

  _ActivityItem(this.data);

  @override
  Widget build(BuildContext context) {
    return new RatedSizedBox(
        height: 0.048,
        child: new Row(
          children: <Widget>[
            new Container(
              color: data.iconColor,
              child: new RatedSizedBox(
                  width: 0.0373333,
                  height: 0.0373333,
                  child: new Center(
                    child: new Text(
                      data.iconName,
                      style: new TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            new RatedPadding(
              padding: new EdgeInsets.only(left: 0.016),
              child: new Text(data.description),
            )
          ],
        ));
  }
}

class _ActivitiesState extends State<_Activities>
    with SingleTickerProviderStateMixin {
  bool _show = false;

  Animation<double> rotation;
  AnimationController controller;

  _ActivitiesState();

  @override
  void initState() {
    controller = new AnimationController(vsync: this);
    rotation = new Tween(begin: 0.0, end: 1.0).animate(controller);
    super.initState();
  }

  Widget buildFirst() {
    return new Row(
      children: <Widget>[
        new Expanded(child: new _ActivityItem(widget.data[0])),
        new GestureDetector(
          onTap: () {
            setState(() {
              _show = !_show;
              if (_show) {
                controller.animateTo(0.5,
                    duration: new Duration(milliseconds: 300),
                    curve: Curves.ease);
              } else {
                controller
                    .animateTo(1.0,
                        duration: new Duration(milliseconds: 300),
                        curve: Curves.ease)
                    .whenComplete(() {
                  controller.value = 0.0;
                });
              }
            });
          },
          child: new RotationTransition(
            turns: rotation,
            child: new SizedBox(
              width: 14.0,
              height: 14.0,
              child: new Center(
                child: new Icon(
                  Icons.keyboard_arrow_down,
                  size: 10.0,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    int len = widget.data.length;

    if (len > 0) {
      children.add(buildFirst());
    }

    if (!_show) {
      len = len > 2 ? 2 : len;
    }

    for (int i = 1; i < len; ++i) {
      children.add(new _ActivityItem(widget.data[i]));
    }

    return new AnimatedContainer(
        duration: new Duration(milliseconds: 300),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ));
  }
}

/// 美食列表项目 , 与推荐商家一样
class RestaurantItem extends StatelessWidget {
  final RestaurantInfo info;

  RestaurantItem(this.info);

  /// 商家优惠活动
  Widget buildActivities() {
    return new _Activities(info.activities);
  }

  Widget buildTitles() {
    return new Container(
        child: new RatedSizedBox(
            height: 0.173333333,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(info.name,
                        style: new TextStyle(
                          fontSize: 17.0,
                          color: Style.text.black3,
                          fontWeight: FontWeight.bold,
                        )),
                    new Text("..."),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new RatingBar(rating: info.rating),
                        new Text("${info.rating} 月售${info.recentOrderNum}"),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text("准时达"),
                        new Fengniao(),
                      ],
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("起送¥${info.minOrderAmt} | 配送¥${info.deliveryFee}"),
                    new Text("${info.leadTime}分钟 | ${info.distance}"),
                  ],
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return new RatedPadding(
        padding: new EdgeInsets.fromLTRB(
          0.026666666,
          0.04,
          0.026666666,
          0.04,
        ),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new RatedSizedBox(
              width: 0.173333333,
              height: 0.173333333,
              child: new Image.network(info.img),
            ),
            new Expanded(
                child: new RatedPadding(
              padding: new EdgeInsets.only(left: 0.026666666),
              child: new Column(
                children: <Widget>[buildTitles(), buildActivities()],
              ),
            ))
          ],
        ));
  }
}
