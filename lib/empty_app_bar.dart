
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'dart:io';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize => new Size(0.0, Platform.isAndroid ? 20.0 : 0.0);
}
