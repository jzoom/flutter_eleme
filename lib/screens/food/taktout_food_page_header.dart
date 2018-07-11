import 'package:flutter/material.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';
import 'dart:math' as Math;

import 'package:flutter_svg/flutter_svg.dart';
//// 整个页面的头部,带有搜索
//new Row(

//children: <Widget>[
//new Text("全部"),
//new Text("简餐便当"),
//new Text("面食"),
//new Text("面食"),
//new Text("面食"),
//new Text("面食"),
//new Text("面食"),
//new Text("面食")
//],
//
//)
///
///
///
///
/// 0.1639344
/// 0.4181818
class TakeoutFoodHeader extends SliverPersistentHeaderDelegate {

  final Key key;

  TakeoutFoodHeader({this.key});

  Widget buildSearchBar(){
    return new RatedPadding(
      padding: new EdgeInsets.fromLTRB(0.03733333, 0.02, 0.03733333, 0.02),
      child: new RatedSizedBox(
        height: 0.1,
        child: new Container(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildQuickSearchItem(String title){
    return new Padding(padding: new EdgeInsets.all(8.0),child: new Text(title,style:new TextStyle( fontSize: 13.0, color: Colors.white )),) ;
  }

  Widget buildQuickSearch( double shrinkOffset){
    return new Align(
      child: new Opacity(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ["土豆","烤鱼","饺子","披萨"].map(( String title)=>
            buildQuickSearchItem(title)).toList(),

          ) ,opacity:


      shrinkOffset > 30.0 ? Math.max(1.0 - (shrinkOffset-30.0)/20.0,0.0)  : 1.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new DecoratedBg(
        key:key,
        child:new SizedBox(
      height: Math.max( maxExtent - shrinkOffset , minExtent),
      child: new Stack(
        children: <Widget>[
          buildQuickSearch(shrinkOffset),
          new Positioned(child:new Opacity(opacity:Math.max( 1.0 - shrinkOffset / 20.0,0.0),child: new PositionWidget(),)  ,left:0.0,right:0.0,top:-shrinkOffset),
          new Positioned(child: buildSearchBar(),top:Math.max(-shrinkOffset+50.0,20.0),right:0.0,left:0.0),
        ],
      ),

    ));
  }

  // TODO: implement maxExtent
  @override
  double get maxExtent => Layout.width * 0.15 + 20 + 50;

  // TODO: implement minExtent
  @override
  double get minExtent => Layout.width * 0.15 + 20;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


class PositionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.only(top: 20.0),
        child: new RatedPadding(
          padding:
              new EdgeInsets.fromLTRB(0.03733333, 0.02666667, 0.03733333, 0.0),
          child: new Row(
            children: <Widget>[
              new RatedSizedBox(
                width: 0.4,
                child: new Row(
                  children: <Widget>[
                    new RatedSizedBox(
                      width: 0.03466667,
                      height: 0.04133333,
                      child: new SvgPicture.asset("assets/position.svg"),
                    ),
                    new Expanded(
                      child: new RatedPadding(
                        padding: new EdgeInsets.only(left: 0.01333333),
                        child: new Text("英雄路188号",
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
