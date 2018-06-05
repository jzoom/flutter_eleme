import 'package:flutter/material.dart';

///
/// 列表中的推荐项目
///
class RecommandItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new SizedBox(
          height: 100.0,
        ),
        new Text(
          "经典牛扒+自然香料...",
          style: new TextStyle(fontWeight: FontWeight.w600),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        new Text(
          "178人好评",
          style: new TextStyle(color: Colors.grey, fontSize: 11.0),
        ),
        new Row(
          children: <Widget>[
            new Text(
              "¥",
              style: new TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
            new Text("27.99",
                style:
                    new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            new DecoratedBox(
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(3.0),
                    border: new Border(
                        top: new BorderSide(color: Colors.red, width: 0.5),
                        bottom: new BorderSide(color: Colors.red, width: 0.5),
                        left: new BorderSide(color: Colors.red, width: 0.5),
                        right: new BorderSide(color: Colors.red, width: 0.5))),
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                  child: new Text(
                    "慢20减15",
                    style: new TextStyle(fontSize: 10.0, color: Colors.red),
                  ),
                ))
          ],
        )
      ],
    );
  }
}
