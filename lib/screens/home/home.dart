import 'package:flutter/material.dart';

import 'package:flutter_eleme/screens/food/takeout_food.dart';
import 'package:flutter_eleme/screens/found/found.dart';
import 'package:flutter_eleme/screens/order/order.dart';
import 'package:flutter_eleme/screens/mine/mine.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/utils/style.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

const List<String> TITLES = ["外卖", "订单", "我的"];

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  Widget buildBody() {
    return new IndexedStack(
      index: _index,
      children: <Widget>[
        new TakeoutFoodPage(),
        new FoundPage(),
        new OrderPage(),
        new MinePage(),
      ],
    );
  }

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  void didChangeDependencies() {
    Layout.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: buildBody(),
      bottomNavigationBar: new _NavigationBar(
        data: [
          {'icon': 'food', 'title': '外卖'},
          {'icon': 'found', 'title': '发现'},
          {'icon': 'order', 'title': '订单'},
          {'icon': 'mine', 'title': '我的'},
        ],
        selectedIndex: _index,
        onTap: _onTap,
      ),
    );
  }
}

const double _kTopMargin = 2.0;
const double _kPadding = 4.0;
const double _kIconSize = 22.0;

class _NavigationBar extends StatelessWidget {
  List<Map> data;
  int selectedIndex;
  ValueChanged<int> onTap;

  _NavigationBar({this.data, this.selectedIndex, this.onTap});

  Widget buildItem(BuildContext context, int index) {
    Map data = this.data[index];
    bool selected = index == selectedIndex;

    ThemeData themeData = Theme.of(context);

    return new Expanded(
        child: new GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(0.0, _kPadding, 0.0, _kPadding),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new _BottomIcon(
              name: data['icon'],
              selected: selected,
            ),
            new Container(
                margin: new EdgeInsets.only(top: _kTopMargin),
                child: new Text(
                  data['title'],
                  style: new TextStyle(
                      fontSize: Style.text.small,
                      color: selected
                          ? themeData.primaryColor
                          : themeData.textTheme.caption.color),
                ))
          ],
        ),
      ),
      onTap: () {
        onTap(index);
      },
    ));
  }

  List<Widget> buildButtons(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0, c = this.data.length; i < c; ++i) {
      list.add(buildItem(context, i));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(boxShadow: <BoxShadow>[
        new BoxShadow(
          blurRadius: 3.0,
          color: Colors.black12,
          offset: new Offset(0.0, -3.0),
        )
      ]),
      child: new Container(
        child: new Row(
          children: buildButtons(context),
        ),
        color: Colors.white,
      ),
    );
  }
}

class _BottomIcon extends StatelessWidget {
  String name;
  bool selected;

  _BottomIcon({this.name, this.selected});

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        width: _kIconSize,
        height: _kIconSize,
        child: new SvgPicture.asset(
            "assets/${name}${selected?"_selected":""}.svg"));
  }
}
