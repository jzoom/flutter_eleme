import 'package:flutter/material.dart';


///
/// 商家筛选条件菜单
///
class BusinessFilter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _BusinessFilterState();
  }

}


class _BusinessFilterState extends State<BusinessFilter>{

  int _businessCount = 0;

  _BusinessFilterState();





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(BusinessFilter oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  /// 清空筛选条件
  void _clear(){

  }

  void _view(){

  }

  Widget buildBottom(){
    return new Row(
      children: <Widget>[

        new Expanded(child: new FlatButton(onPressed: _clear, child: new Text("清空"))),
        new Expanded(child: new RaisedButton(onPressed: _view,child: new Text("查看$_businessCount个商家"),))

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(

      children: <Widget>[

        new Expanded(child: new SingleChildScrollView(

          child: new Column(
            children: <Widget>[

            ],
          ),

        )),

        buildBottom()

      ],

    );
  }

}