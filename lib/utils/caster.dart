library caster;

import 'dart:convert';
import 'package:flutter/widgets.dart';

abstract class ValueCaster<SRC, DEST> {
  DEST to(SRC value);
}

class CastException implements Exception {
  final String message;

  CastException([this.message]);
}

///  Value caster class
///
/// Future:
///
/// Basic value cast:
///
/// Caster.to( 1, double ) ->  1,0
/// Caster.to( true, int)  ->  1
/// Caster.to( false, int) -> 0
/// Caster.to( 1.6, int )  -> 1
///
///
/// json cast:
///
/// Caster.to( "{}" , Map ) -> Empty Map
/// Caster.to("[]", List )   -> Empty List
///
/// Caster.to(new Map(), String) -> "{}"
/// ...
///
///
///
class Caster {
  static Map<String, ValueCaster> map = new Map<String, ValueCaster>();

  static Set<Type> srcList = new Set<Type>();
  static Set<Type> destList = new Set<Type>();

  static void register(Type src, Type dest, ValueCaster caster) {
    srcList.add(src);
    destList.add(dest);
    map["$src:$dest"] = caster;
  }

  static void init() {
    // register(num, double, new _Num2Double());

    register(int, double, new _Int2Double());
    register(bool, double, new _Bool2Double());
    register(String, double, new _String2Double());

    register(double, int, new _Double2Int());
    register(bool, int, new _Bool2Int());
    register(String, int, new _String2Int());

    register(String, bool, new _String2Bool());
    register(double, bool, new _Double2Bool());
    register(int, bool, new _Int2Bool());

    register(String, Map, new _String2Map());
    register(Map, String, new _Json2String());
    register(List, String, new _Json2String());
    register(String, List, new _String2List());

    register(String, Color, new _String2Color());
  }

  static T to<T>(dynamic value, Type type) {
    if (value == null) {
      return null;
    }

    assert(type != null);

    Type srcType = value.runtimeType;
    if (srcType == type) {
      return value;
    }

    String src = srcType.toString();
    String dest = type.toString();

    ValueCaster caster = map["$src:$dest"];
    if (caster == null) {
      throw new CastException("Cannot find caster from $src to $dest!");
    }

    return caster.to(value);
  }
}

class _Num2Double implements ValueCaster<num, double> {
  @override
  double to(num value) {
    return value.toDouble();
  }
}

RegExp kColorExp = new RegExp("[0-9a-fA-F]+");

class _String2Color implements ValueCaster<String, Color> {
  @override
  Color to(String value) {
    if (value.startsWith("#")) {
      value = value.substring(1);
    }

    if (value.length == 3) {
      if (kColorExp.hasMatch(value)) {
        String realValue = "ff";
        for (int i = 0; i < 3; ++i) {
          realValue += value.substring(i, i + 1) + value.substring(i, i + 1);
        }
        return new Color(int.parse(realValue, radix: 16));
      }
    } else if (value.length == 6) {
      if (kColorExp.hasMatch(value)) {
        return new Color(int.parse("ff" + value, radix: 16));
      }
    } else if (value.length == 8) {
      if (kColorExp.hasMatch(value)) {
        return new Color(int.parse(value, radix: 16));
      }
    }

    throw new CastException("Color format must be #000|#000000|#00000000");
  }
}

class _Int2Double implements ValueCaster<int, double> {
  @override
  double to(int value) {
    return value.toDouble();
  }
}

class _Double2Bool implements ValueCaster<double, bool> {
  @override
  bool to(double value) {
    return value == 0.0 ? false : true;
  }
}

class _Int2Bool implements ValueCaster<int, bool> {
  @override
  bool to(int value) {
    return value == 0 ? false : true;
  }
}

class _Bool2Double implements ValueCaster<bool, double> {
  @override
  double to(bool value) {
    return value ? 1.0 : 0.0;
  }
}

class _String2Double implements ValueCaster<String, double> {
  @override
  double to(String value) {
    return double.parse(value);
  }
}

class _Double2Int implements ValueCaster<double, int> {
  @override
  int to(double value) {
    return value.toInt();
  }
}

class _String2Bool implements ValueCaster<String, bool> {
  @override
  bool to(String value) {
    value = value.toLowerCase();
    if ("false" == value) {
      return false;
    } else if ("true" == value) {
      return true;
    }

    return true;
  }
}

class _String2Int implements ValueCaster<String, int> {
  @override
  int to(String value) {
    return int.parse(value);
  }
}

class _Bool2Int implements ValueCaster<bool, int> {
  @override
  int to(bool value) {
    return value ? 1 : 0;
  }
}

class _Json2String implements ValueCaster<Object, String> {
  @override
  String to(Object value) {
    return json.encode(value);
  }
}

class _String2Map implements ValueCaster<String, Map> {
  @override
  Map to(String value) {
    return json.decode(value);
  }
}

class _String2List implements ValueCaster<String, List> {
  @override
  List to(String value) {
    return json.decode(value);
  }
}
