import 'package:flutter/material.dart';
import 'package:flutter_eleme/utils/style.dart';
import 'package:flutter_eleme/widgets/decorated_app_bar.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';
import 'package:flutter_svg/svg.dart';


class _MineItemData{
  final String title;
  final String icon;
  final String subtitle;
  final bool isNew;

  _MineItemData({this.title,this.icon,this.subtitle,this.isNew:false});
}

class MinePage extends StatelessWidget {

  /// 收货地址等小项目
  Widget buildItem(_MineItemData data){
    return new _MineItem(data:data);
  }


  /// 钱包、优惠、金币等项目
  Widget buildWallet(String title, String subtitle ,String description,Color color){
    return new Padding(padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          new Text(title,style: new TextStyle(fontSize: Style.text.number,fontWeight: FontWeight.bold,color: color),),
          new Text(subtitle,style: new TextStyle(color: color),)
        ],),
        new Text(description,style: new TextStyle(fontSize: Style.text.body2,color: Style.text.black3),)
      ],

    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(color: new Color(0xfff5f5f5),child: new Column(
      children: <Widget>[
        new DecoratedAppBar(title: "我的",),

          new Expanded(child: new SingleChildScrollView(

            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                new DecoratedBg(
                    child: new Padding(padding: const EdgeInsets.fromLTRB(  10.0, 15.0, 10.0,15.0),
                    child: new Row(

                      children: <Widget>[

                        new Container(),
                        new Expanded(child: new Column(
                          children: <Widget>[

                            new Row(
                              children: <Widget>[

                                new Text("4*****9",style: new TextStyle(fontSize: 20.0,color:Colors.white),),


                              ],

                            ),

                            new Row(
                              children: <Widget>[

                                new SizedBox(

                                ),
                                new Text("188****8888",style:new TextStyle(color: Colors.white ))

                              ],
                            )


                          ],
                        ),
                        ),

                        new Icon(Icons.keyboard_arrow_right, color: Colors.white, ),

                      ],

                    ) ,)
                ),


                bottomDivider(context,
                    new Container(
                      color: Colors.white,
                      child: new Row(
                          children: <Widget>[
                            new Expanded(child: rightDivider(context,buildWallet( "0.00","元", "钱包", Theme.of(context).primaryColor))),
                            new Expanded(child:rightDivider(context,buildWallet( "3","个", "优惠", new Color(0xffED6747)))),
                            new Expanded(child: buildWallet( "7","个", "金币",new Color(0xffF3A53B))),
                          ])),
                    ),
                new Padding(padding: const EdgeInsets.only(top:10.0)),


                new Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10.0,15.0,10.0,15.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[

                      new Container(),

                      new Expanded(child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("超级会员特权",style: new TextStyle(fontSize: 13.0),),
                          new Text("获得1个奖励金，可兑无门槛红包",style: new TextStyle(fontSize: 15.0),),
                        ],

                      )),

                      new Icon(Icons.keyboard_arrow_right,color: Colors.black26,)

                    ],

                  )
                ),
                new Padding(padding: const EdgeInsets.only(top:10.0)),

                new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ListTile.divideTiles( context: context, tiles:  <_MineItemData>[

                    new _MineItemData(title: "收货地址" ,icon: "assets/found.svg"),
                    new _MineItemData(title: "我的收藏" ,icon: "assets/found.svg")

                  ].map(buildItem) ).toList()  ,
                ),

                new Padding(padding: const EdgeInsets.only(top:10.0)),

                new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ListTile.divideTiles( context: context, tiles:  <_MineItemData>[

                    new _MineItemData(title: "推荐有奖" , subtitle: "5元现金拿不停", icon: "assets/mine.svg"),
                    new _MineItemData(title: "金币商城" , subtitle: "0元好物在这里",icon: "assets/found.svg"),
                    new _MineItemData(title: "饿了么联名卡",subtitle: "免费领百元红包" ,icon: "assets/found.svg" ,isNew: true ),
                    new _MineItemData(title: "城市代理申请",subtitle: "最高6个月免抽奖" ,icon: "assets/found.svg",isNew: true)

                  ].map(buildItem) ).toList()  ,

                )




              ],

            ),

          ))

        ],
      )),
    );
  }
}



///
class _MineItem extends StatelessWidget{


  final _MineItemData data;

  _MineItem({this.data});



  @override
  Widget build(BuildContext context) {

    List<Widget> after = [];

    if(data.isNew){
      after.add(new _New());
    }

    if(data.subtitle!=null){
      after.add(new Text(data.subtitle));
    }

    after.add( new Icon(Icons.keyboard_arrow_right,color: Colors.black26,));
      return new Container(
          color: Colors.white,
          child: new Padding(padding: const EdgeInsets.all(10.0),child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new SizedBox(
                width: 20.0,
                height: 20.0,
                child: new SvgPicture.asset(data.icon),
              ),
              new Padding(padding: const EdgeInsets.only(left:8.0),child:new Text(data.title,
                style: new TextStyle(fontSize: Style.text.mine,color: Colors.black),)),
            ],
          ),

          new Row(
            children: after,
          ),


        ],

      )));
  }

}


class _New extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Padding(padding: const EdgeInsets.only(right: 5.0),child:new ClipRRect(
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      child: new Container(
        color: new Color(0xffEC4A2F),
        child:  new Padding(padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),child:new Text("New",style: new TextStyle(color: Colors.white),)),
      ),
    ));
  }

}