import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


const String kBaseUrl =
    "http://result.eolinker.com/zTpxSm31b0f0b72f3f888a54bbafc97d3f75a2a63aeaa2c?uri=http://my.com/";

///
/// 网络请求，这里是使用eolinker的mock功能模拟网络数据
///
/// 在实际的项目中，可能要支持token机制，本项目将加入后端的实现，支持单点登录、推送等常用功能
/// 敬请期待
///
Future<T> fetch<T>(String api) async {
  print("Start load " + api);
  http.Response response = await http.get(kBaseUrl + api);
  Encoding encoding = Encoding.getByName("utf-8");
  return json.decode(encoding.decode(  response.bodyBytes));
}
