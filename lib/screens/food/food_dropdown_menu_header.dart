import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eleme/utils/config.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/utils/style.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';
import 'package:flutter_svg/svg.dart';




class TakeoutFoodHeaderMenuDelegate extends SliverPersistentHeaderDelegate {


  final ValueChanged<int> onTap;
  final int firstMenuIndex;
  final Set<Map> filter;

  TakeoutFoodHeaderMenuDelegate( {this.onTap,this.firstMenuIndex,this.filter} );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return bottomDivider(
        context,
        new SizedBox(
          height: 46.0,
          child: new FoodDropdownMenuHeader(onTap:onTap ,firstMenuIndex:firstMenuIndex,filter:filter  ),
        ));
  }

  @override
  double get maxExtent => 46.0;

  @override
  double get minExtent => 46.0;

  @override
  bool shouldRebuild(TakeoutFoodHeaderMenuDelegate oldDelegate) {
    return firstMenuIndex != oldDelegate.firstMenuIndex || filter != oldDelegate.filter ;
  }
}


/// 列表中间的下拉菜单项目  排序、距离最近、会员领红包等
class FoodDropdownMenuHeader extends DropdownWidget {

  final ValueChanged<int> onTap;

  final int firstMenuIndex;
  final Set<Map> filter;

  FoodDropdownMenuHeader({this.onTap,this.filter,this.firstMenuIndex});


  @override
  DropdownState<DropdownWidget> createState() {
    return new _FoodDropDownMenuHeaderState();
  }
}

class _FoodDropDownMenuHeaderState
    extends DropdownState<FoodDropdownMenuHeader> {


  Set<Map> _filter;
  /// 菜单是否激活
  bool _menuActive = false;
  String _title0;

  _FoodDropDownMenuHeaderState();

  void initState(){
    _filter = widget.filter;

    _updateProps();

    super.initState();
  }

  void _onTap(int index){
    switch(index){
      case 0:
        widget.onTap(index);
        break;
      case 1:
        {
          controller.select(  Config.nearest , index: null,subIndex: null, menuIndex: 1  );
        }
        break;
      case 2:
        {

        }
        break;
      case 3:
        widget.onTap(index);
        break;
    }

  }

  void _updateProps(){
    int firstMenuIndex = widget.firstMenuIndex;
    if(firstMenuIndex==null){
      firstMenuIndex = 0;
    }
    _title0 = Config.orders[firstMenuIndex]['title'];

  }

  ///  selected : 是否是高亮选中
  ///
  /// 状态：
  ///
  /// 菜单激活：    选中项目为蓝色高亮，其他为普通颜色
  /// 菜单非激活：   选中项目为黑体高亮，其他为普通颜色
  ///
  ///
  Widget buildItem(BuildContext context, int index , bool selected ) {

    Color color = _getColor(index, selected);

    FontWeight weight = _getWeight(index,selected);

    switch (index) {
      case 0:
        return new Container(
          height: 46.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                _title0,
                style: new TextStyle(fontSize: Style.text.menu ,color: color,fontWeight: weight ),
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
          style: new TextStyle(fontSize: Style.text.menu ,color: color,fontWeight: weight),
        )));
      case 2:
        return  new Container(
          height: 46.0,
          child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              width: 20.0,
              height: 20.0,

              child:  new SvgPicture.asset("assets/account.svg",color:new Color(0xffF4C148),),
            ),

            new Text("会员领红包", style: new TextStyle(fontSize: Style.text.menu ,color: color,fontWeight: weight)),
          ],
        ));
      case 3:
        return  new Container(
            height: 46.0,
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("筛选", style: new TextStyle(fontSize: Style.text.menu ,color: color,fontWeight: weight)),

            new RatedPadding(padding: new EdgeInsets.only(left:0.00533333),child:
            new RatedSizedBox(
              width: 0.03466667,
              height: 0.03466667,
              child:  new SvgPicture.asset("assets/filter.svg",color: Style.color.fontColor,),
            )),
          ],
        ));
    }
    return null;
  }


  FontWeight _getWeight(int index,bool selected){

    return  (!_menuActive && selected) ? FontWeight.bold : null;


  }

  Color _getColor(int index,bool selected){

    switch(index){
      case 0:
        if( _menuActive && controller.menuIndex==0 ) {
          return Theme.of(context).primaryColor;
        }
        break;
      case 1:
        {
          return null;
        }

      case 2:
        {
          return null;
        }

      case 3:
        if( _menuActive && selected ) {
          return Theme.of(context).primaryColor;
        }

    }
    return null;

  }

  bool _isSelected(int index){

    switch(index){
      case 0:
        return widget.firstMenuIndex != null;
      case 1:
        return widget.firstMenuIndex == null;
      case 2:
        return false;
      case 3:
        return false;
    }
    return null;


  }

  Widget buildItemWithGesture(int i){
    return new Expanded(
        child: new GestureDetector(
          child: buildItem(context, i, _isSelected(i)),
          onTap: (){
            _onTap(i);
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
    switch(event){
      case DropdownEvent.ACTIVE:
        _menuActive = true;
        break;
      case DropdownEvent.HIDE:
      case DropdownEvent.SELECT:
        _menuActive = false;
        break;
    }
    setState(() {

    });
  }
}
