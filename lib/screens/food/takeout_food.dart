import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_eleme/screens/food/discount_business.dart';
import 'package:flutter_eleme/screens/food/takeout_food_dropdown_menu_controller.dart';
import 'package:flutter_eleme/screens/food/taktout_food_page_header.dart';
import 'package:flutter_eleme/services/food_service.dart';
import 'package:flutter_eleme/widgets/recommand_item.dart';

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


  ScrollController controller;


  @override
  void initState() {
    _fetchDiscountBusinessInfos();
    _fetchRestaurants();

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

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new TakeoutFoodDropdownMenuController(
      titleHeaderBuilder:  (Key key) {
        return new TakeoutFoodHeader(key:key);
      },

      listItemBuilder: (BuildContext context, int index){
        return new RestaurantItem(_restaurants[index]);
      },

      listHeaderChildren: <Widget>[
        new Image.network(
            "https://fuss10.elemecdn.com/2/7a/946aba678f06545c946a8fe8fedf0jpeg.jpeg?imageMogr/format/webp/"),
        new DiscountBusiness(data: _discountBusiness),
      ],

      data: _restaurants

    );
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
