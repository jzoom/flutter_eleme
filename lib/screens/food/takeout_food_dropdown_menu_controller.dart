



import 'package:dropdown_menu/dropdown_list_menu.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eleme/screens/food/business_filter.dart';
import 'package:flutter_eleme/screens/food/food_dropdown_menu_header.dart';
import 'package:flutter_eleme/utils/config.dart';
import 'package:flutter_eleme/utils/layout.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';
import 'package:dropdown_menu/dropdown_templates.dart';


/// 标题栏头部builder，参数是一个key，需要将这个key放在头部根节点上面测量高度
typedef SliverPersistentHeaderDelegate TitleHeaderDelegateBuilder( Key key  );

class TakeoutFoodDropdownMenuController<T> extends StatefulWidget {



  /// 用于构建列表的项目
  final IndexedWidgetBuilder listItemBuilder;


  /// 用于构建列表的数据
  final List<T> data;

  /// 在列表上面，页面头部下面的部分
  final List<Widget> listHeaderChildren;

  /// 如果有，那么头部有头
  final TitleHeaderDelegateBuilder titleHeaderBuilder;



  TakeoutFoodDropdownMenuController({this.listItemBuilder,this.data,
    this.listHeaderChildren,
    this.titleHeaderBuilder});

  @override
  State<StatefulWidget> createState() {
    return new _TakeoutFoodDropdownMenuControllerState();
  }
}



class _TakeoutFoodDropdownMenuControllerState extends State<TakeoutFoodDropdownMenuController>{
  ScrollController controller;
  GlobalKey _topHeaderKey;
  GlobalKey _listHeaderKey;

  /// 菜单下标,注意和第二个菜单有联动关系，也就是排序只能选择一个
  int _firstMenuIndex = 0;
  int _oldFirstMenuIndex ;
  /// 所有筛选条件
  Set<Map> _filters = new Set();



  @override
  void initState() {

    controller = new ScrollController();

    _topHeaderKey = new GlobalKey();
    _listHeaderKey = new GlobalKey();

    _oldFirstMenuIndex = _firstMenuIndex;



    super.initState();
  }


  void _onMenuTap(int index){

    /// 这里修正一下从外面传进来的index，外面定义的菜单只有两个，而这里的点击项有4个，
    int menuIndex = index == 0 ? 0 : 1;

    DropdownMenuController menuController = DefaultDropdownMenuController.of( _listHeaderKey.currentContext);

    double height = _listHeaderKey.currentContext.size.height;

    if(controller.offset >= height + 50.0){
      //如果头部没有完全缩进去,那么要向上偏移一下
      if(_topHeaderKey.currentContext.size.height > Layout.width * 0.15 + 20){
        double offset = _topHeaderKey.currentContext.size.height - Layout.width * 0.15 + 20;

        controller.animateTo(controller.offset+offset, duration:new Duration(milliseconds: 150), curve: Curves.ease).
        whenComplete( (){
          menuController.show(menuIndex);
        });
      }else{
        menuController.show(menuIndex);
      }


    }else{
      controller.animateTo( height + 50.0  , duration: new Duration(milliseconds: 300), curve: Curves.ease)
          .whenComplete( (){
        menuController.show(menuIndex);
      });

    }

  }


  /// 整个列表的头部
  SliverList buildHeader() {
    return new SliverList(
        delegate:
        new SliverChildBuilderDelegate((BuildContext context, int index) {
          return new Column(
            key:_listHeaderKey,
            mainAxisSize: MainAxisSize.min,
            children: widget.listHeaderChildren,
          );
        }, childCount: 1));
  }


  /// 列表
  SliverList buildList(BuildContext context) {

    final IndexedWidgetBuilder listItemBuilder = widget.listItemBuilder;
    return new SliverList(
        delegate:
        new SliverChildBuilderDelegate((BuildContext context, int index) {
          return bottomDivider(context, listItemBuilder( context, index) );
        }, childCount: widget.data.length));
  }

  ///
  Widget buildPage() {
    List<Widget> list = [];


    if(widget.titleHeaderBuilder!=null){
      /// 分段的头部，固定头,这个头部只有主页有，其他都不是通过这种方式实现
      /// 比如美食页面，头部是个定制的控件，但是并不包含在CustomScrollView中
      ///
      SliverPersistentHeader titleHeader = new SliverPersistentHeader(
          pinned: true, floating: true, delegate:widget.titleHeaderBuilder(_topHeaderKey));
      list.add(titleHeader);
    }


    if(widget.listHeaderChildren!=null){
      /// 头部下面，和菜单头部的中间部分
      list.add( buildHeader());
    }

    /// 下拉菜单头部
    list.add(
      new SliverPersistentHeader(
          pinned: true,
          delegate: new TakeoutFoodHeaderMenuDelegate( onTap: _onMenuTap ,filter: _filters,firstMenuIndex: _firstMenuIndex )),
    );
    /// 菜单下面的列表
    list.add(  buildList(context) );

    return new CustomScrollView(
      controller:controller,
      primary: false,
      slivers: list,
    );
  }


  void _onSelect( {int menuIndex, int index, int subIndex, dynamic data}){
    //选择了之后，需要刷新条件，并重新请求网络
    if(menuIndex==0){
      setState(() {
        _firstMenuIndex = index;

      });
    }else if(menuIndex == 1) {
      setState(() {

        if(_firstMenuIndex==null){
          _firstMenuIndex = _oldFirstMenuIndex;
        }else{
          _oldFirstMenuIndex = _firstMenuIndex;
          _firstMenuIndex = null;
        }


      });
    }else if(menuIndex==2){
      //增加筛选条件


    }else{
      //修改筛选条件

    }

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return new DefaultDropdownMenuController(
      onSelected: _onSelect,
        child: new Stack(
          children: <Widget>[
            buildPage(),
            new Positioned(
                child: new DropdownMenu(menus: <DropdownMenuBuilder>[
                  new DropdownMenuBuilder(
                      builder: (BuildContext context) {
                        return new DropdownListMenu(
                          selectedIndex: _firstMenuIndex,
                          data: Config.orders,
                          itemBuilder: buildCheckItem,
                        );
                      },
                      height: Layout.percent(kDropdownMenuItemHeight*4.0/375.0)),
                  new DropdownMenuBuilder(builder:  (BuildContext context){

                    return new BusinessFilter(

                    );

                  },height: data.size.height * 0.7 )
                ]),
                top: Layout.percent(0.15) + 20 + Layout.percent(kDropdownMenuItemHeight/375.0),
                left: 0.0,
                bottom: 0.0,
                right: 0.0),
          ],
        ));
  }

}
