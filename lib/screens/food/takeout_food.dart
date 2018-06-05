import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_eleme/screens/food/discount_business.dart';
import 'package:flutter_eleme/screens/food/food_dropdown_menu_header.dart';
import 'package:flutter_eleme/screens/food/taktout_food_page_header.dart';
import 'package:flutter_eleme/services/food_service.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:dropdown_menu/dropdown_header.dart';
import 'package:flutter_eleme/widgets/recommand_item.dart';
import 'package:dropdown_menu/dropdown_list_menu.dart';
import 'package:dropdown_menu/dropdown_templates.dart';
import 'dart:math' as Math;

import 'restaurant_item.dart';

class TakeoutFoodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FoodPageState();
  }
}


class _FoodPageState extends State<TakeoutFoodPage>
    with TickerProviderStateMixin {
  List<List<DiscountBusinessInfo>> _discountBusiness = [];
  List<RestaurantInfo> _restaurants = [];
  GlobalKey _headerKey;
  ScrollController controller;

  double _screenWidth;

  @override
  void initState() {
    _fetchDiscountBusinessInfos();
    _fetchRestaurants();
    _headerKey = new GlobalKey();

    controller = new ScrollController();

    super.initState();
  }



  void _fetchDiscountBusinessInfos() async {
    try {
      List<List<DiscountBusinessInfo>> list = await getDiscountBusinessInfos();
      setState(() {
        _discountBusiness = list;
      });
    } catch (e) {
      print(e);
    }
  }

  void _fetchRestaurants() async {
    try {
      List<RestaurantInfo> list = await getRestaurants();
      setState(() {
        _restaurants = list;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    if(controller!=null)controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _screenWidth = MediaQuery.of(context).size.width;


    super.didChangeDependencies();
  }

  /// 餐厅列表
  SliverList buildRestaurantsList() {
    return new SliverList(
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
      return createDivider(context, new RestaurantItem(_restaurants[index]));
    }, childCount: _restaurants.length));
  }

  /// 整个列表的头部
  SliverList buildHeader() {
    return new SliverList(
      key:_headerKey,
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.network(
              "https://fuss10.elemecdn.com/2/7a/946aba678f06545c946a8fe8fedf0jpeg.jpeg?imageMogr/format/webp/"),
          new DiscountBusiness(data: _discountBusiness),
        ],
      );
    }, childCount: 1));
  }


  /**
   * 按钮
   */
  void _onMenuTap(int index){

    DropdownMenuController menuController = DefaultDropdownMenuController.of( _headerKey.currentContext);

    double height = 0.0;
    _headerKey.currentContext.visitChildElements( (Element element){
      height+=element.size.height;
    });

    if(controller.offset >= height + 50.0){
      menuController.show(0);
    }else{
      controller.animateTo( height + 50.0  , duration: new Duration(milliseconds: 300), curve: Curves.ease)
        .whenComplete( (){
        menuController.show(0);
      });

    }



    ///controller.animateTo(offset, duration: new Duration(milliseconds: 300), curve: Curves.ease);

  }


  Widget buildPage() {
    MediaQueryData data = MediaQuery.of(context);
    return new CustomScrollView(
      controller:controller,
      primary: false,
      slivers: <Widget>[
        new SliverPersistentHeader(
            pinned: true, floating: true, delegate: new TakeoutFoodHeader(  )),
        buildHeader(),
        new SliverPersistentHeader(
            pinned: true,
            delegate: new TakeoutFoodHeaderMenuDelegate( onTap:  _onMenuTap)),
        buildRestaurantsList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultDropdownMenuController(
        child: new Stack(
      children: <Widget>[
        buildPage(),
        new Positioned(
            child: new DropdownMenu(menus: <DropdownMenuBuilder>[
              new DropdownMenuBuilder(
                  builder: (BuildContext context) {
                    return new DropdownListMenu(
                      data: ["综合排序", "好评优先", "销量最高", "起送价最低"],
                      itemBuilder: buildCheckItem,
                    );
                  },
                  height: kDropdownMenuItemHeight * 4),
            ]),
            top: Layout.width * 0.15 + 20 + 46.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0),
      ],
    ));
  }
}

///
/// 列表头部推荐
///
class RecommandHeader extends StatelessWidget {
  /// 避免嵌套过多
  Widget buildTop(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new Text(
          "品质套餐",
          style: Theme.of(context).textTheme.title,
        )),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text("更多"),
            new Icon(
              Icons.keyboard_arrow_right,
              size: 20.0,
            )
          ],
        )
      ],
    );
  }

  Widget buildProducts(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(child: new RecommandItem()),
        new SizedBox(
          width: 8.0,
        ),
        new Expanded(child: new RecommandItem()),
        new SizedBox(
          width: 8.0,
        ),
        new Expanded(child: new RecommandItem()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          /// 需要根据子元素计算大小
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[buildTop(context), buildProducts(context)],
        ));
  }
}

class MenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
