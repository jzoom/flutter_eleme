import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _Clipper extends CustomClipper<Rect> {
  final double width;

  _Clipper({this.width});

  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(0.0, 0.0, width, size.height);
  }

  @override
  bool shouldReclip(_Clipper oldClipper) {
    if (this.width != oldClipper.width) return true;
    return false;
  }
}

/// 五星评分控件
class RatingBar extends StatelessWidget {
  final double rating;

  RatingBar({this.rating});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new SizedBox(
          width: 60.0,
          height: 10.0,
          child: new SvgPicture.asset("assets/rating.svg"),
        ),
        new ClipRect(
          clipper: new _Clipper(width: rating / 5.0 * 60.0),
          child: new SizedBox(
            width: 60.0,
            height: 10.0,
            child: new SvgPicture.asset("assets/rating_highlight.svg"),
          ),
        ),
      ],
    );
  }
}
