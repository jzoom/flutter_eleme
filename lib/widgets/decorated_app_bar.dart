import 'package:flutter/material.dart';
import 'package:flutter_eleme/widgets/decorated_widget.dart';

/// 用于首页tab页的标题栏
class DecoratedAppBar extends StatelessWidget{

  final String title;
  final Widget left;
  final Widget right;

  DecoratedAppBar({this.title,this.left,this.right});


  @override
  Widget build(BuildContext context) {

    List<Widget> list = [];

    if(left!=null){
      list.add(left);
    }

    if(title!=null){
      list.add(  new Expanded(child: new Center(child: new Text("我的",style:new TextStyle(fontSize: 18.0,color: Colors.white)),)),
      );
    }

    if(right!=null){
      list.add(right);
    }

    DecoratedBg container = new DecoratedBg(
        child: new Padding(padding: const EdgeInsets.only(top:20.0),child: new SizedBox(
          height: 45.0,
          child: new Row(
            children: list,
          ),
        ),)
    );



    return container;
  }
}