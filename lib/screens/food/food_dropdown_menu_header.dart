import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eleme/utils/style.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';




class TakeoutFoodHeaderMenuDelegate extends SliverPersistentHeaderDelegate {


  ValueChanged<int> onTap;

  TakeoutFoodHeaderMenuDelegate( {this.onTap} );




  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    print("${overlapsContent}  $shrinkOffset");

    return createDivider(
        context,
        new SizedBox(
          height: 46.0,
          child: new FoodDropdownMenuHeader(onTap:onTap ,),
        ));
  }

  // TODO: implement maxExtent
  @override
  double get maxExtent => 46.0;

  // TODO: implement minExtent
  @override
  double get minExtent => 46.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
/// 列表中间的下拉菜单项目  排序、距离最近、会员领红包等
class FoodDropdownMenuHeader extends DropdownWidget {

  ValueChanged<int> onTap;

  FoodDropdownMenuHeader({this.onTap});


  @override
  DropdownState<DropdownWidget> createState() {
    return new _FoodDropDownMenuHeaderState();
  }
}

class _FoodDropDownMenuHeaderState
    extends DropdownState<FoodDropdownMenuHeader> {
  int _index;

  Widget buildItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return new Container(
          height: 46.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "综合排序",
                style: new TextStyle(fontSize: Style.text.menu),
              ),
              new Padding(
                padding: new EdgeInsets.only(left: 3.0),
                child: new Icon(
                  Icons.keyboard_arrow_down,
                  size: 10.0,
                ),
              )
            ],
          ),
        );
      case 1:
        return  new Container(
          height: 46.0,
          child: new Center(
            child: new Text(
          "距离最近",
          style: new TextStyle(fontSize: Style.text.menu),
        )));
      case 2:
        return  new Container(
          height: 46.0,
          child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("会员领红包", style: new TextStyle(fontSize: Style.text.menu)),
          ],
        ));
      case 3:
        return  new Container(
            height: 46.0,
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("筛选", style: new TextStyle(fontSize: Style.text.menu)),
          ],
        ));
    }
  }

  Widget buildItemWithGesture(int i){
    return new Expanded(
        child: new GestureDetector(
          child: buildItem(context, i),
          onTap: () {
            widget.onTap(i);
          },
         behavior: HitTestBehavior.opaque,
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < 4; ++i) {
      list.add(buildItemWithGesture(i));
    }

    return new Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child:new Row(
          children: list,
      ),
    );
  }

  @override
  void onEvent(DropdownEvent event) {
    // TODO: implement onEvent
  }
}
