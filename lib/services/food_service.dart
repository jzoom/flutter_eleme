import 'dart:async';

import 'fetch.dart';

import 'package:flutter_eleme/utils/utils.dart';

import 'package:flutter_eleme/utils/caster.dart';

import 'package:flutter/widgets.dart';

/// 优惠商家信息
class DiscountBusinessInfo {
  String img;
  String name;
  String id;

  DiscountBusinessInfo({this.id, this.img, this.name});
}

///
class ActivityInfo {
  String iconName;
  Color iconColor;
  String description;

  ActivityInfo({this.iconColor, this.iconName, this.description});

  static List<ActivityInfo> from(List data) {
    return data.map((item) {
      return new ActivityInfo(
          iconColor: Caster.to(item['icon_color'], Color),
          iconName: item['icon_name'],
          description: item['description']);
    }).toList();
  }
}

/// 商家信息
class RestaurantInfo {
  String img;
  String name;
  String id;
  double rating;

  double latitude;
  double longitude;

  String distance;

  dynamic leadTime;

  dynamic recent_order_num;

  dynamic minOrderAmt;
  dynamic deliveryFee;

  List<ActivityInfo> activities;

  RestaurantInfo(
      {this.id,
      this.img,
      this.name,
      this.latitude,
      this.longitude,
      this.activities,
      this.rating,
      this.recent_order_num,
      this.leadTime,
      this.minOrderAmt,
      this.deliveryFee,
      this.distance});
}

/// 获取优惠商家信息列表
///
Future<List<List<DiscountBusinessInfo>>> getDiscountBusinessInfos() async {
  List<dynamic> list = await fetch("entries");

  return list.map((dynamic data) {
    List entries = data['entries'];

    return entries.map((item) {
      return new DiscountBusinessInfo(
          id: item["id"].toString(),
          img: hash2url(item['image_hash']),
          name: item['name']);
    }).toList();
  }).toList();
}

Future<List<RestaurantInfo>> getRestaurants() async {
  List<dynamic> list = await fetch("restaurants");

  return list.map((data) {
    return new RestaurantInfo(
        name: data['name'],
        id: data['id'].toString(),
        img: hash2url(data['image_path']),
        latitude: data['latitude'],
        longitude: data['longitude'],
        activities: ActivityInfo.from(data['activities']),
        rating: Caster.to(data['rating'], double),
        deliveryFee: data['float_delivery_fee'],
        leadTime: data['order_lead_time'],
        recent_order_num: data['recent_order_num'],
        minOrderAmt: data['float_minimum_order_amount'],
        distance: formatDistance(data['distance']));
  }).toList();
}
