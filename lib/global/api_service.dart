
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enjoy_android/entity/register_entity.dart';
import 'package:enjoy_android/util/http_util.dart';

import '../entity_factory.dart';
import 'api.dart';

class ApiService{

  static Future<Map> base(String url, Map req, {String type})async{
    var json = await HttpUtils.request(
        url,
        method: type==null||type.isEmpty?HttpUtils.GET:type,
        data: req
    );
    return json;
  }

  ///
  ///注册
  ///
  static Future<Map> register(String username, String password)async{
    var req = {
      'username':username,
      'password':password,
      'repassword':password
    };
    return base(Api.register, req, type: HttpUtils.POST);
//    FormData formData = new FormData.fromMap({
//      'username':username,
//      'password':password,
//      'repassword':password
//    });
//    var json = await HttpUtils.request(
//        Api.register,
//        method: HttpUtils.POST,
//        data: formData
//    );
//    return json;
  }

  ///
  ///登录
  ///
  static Future<Map> login(String username, String password)async{
    var req = {
      'username':username,
      'password':password
    };
    return base(Api.login, req, type: HttpUtils.POST);
//    FormData formData = new FormData.fromMap({
//      'username':username,
//      'password':password
//    });
//    var json = await HttpUtils.request(
//        Api.register,
//        method: HttpUtils.POST,
//        data: formData
//    );
//    return json;
  }

  ///
  ///首页banner
  ///
  static Future<Map> banner()async{
    var req = {
    };
    return base(Api.banner, req);
  }

  ///
  ///首页文章列表
  ///
  static Future<Map> homeArticle(int page)async{
    var req = {
    };
    return base(Api.article+'$page/json', req);
  }

  ///
  ///体系数据
  ///
  static Future<Map> systemTree()async{
    var req = {
    };
    return base(Api.systemTree, req);
  }

  ///
  /// 体系子类数据
  ///
  static Future<Map> systemSub(int page, int cid)async{
    var req = {
    };
    return base(Api.systemSub+'$page/json?cid=$cid', req);
  }

  ///
  /// 导航数据
  ///
  static Future<Map> navigate()async{
    var req = {

    };
    return base(Api.navigate, req);
  }

  ///
  /// 项目分类
  ///
  static Future<Map> projectTree()async{
    var req = {

    };
    return base(Api.projectTree, req);
  }

  ///
  /// 项目列表
  ///
  static Future<Map> projectSub(int page, int cid)async{
    var req = {

    };
    return base(Api.projectSub+'$page/json?cid=$cid', req);
  }

  ///
  /// 搜索热词
  ///
  static Future<Map> hotword()async{
    var req = {
    };
    return base(Api.hotword, req);
  }

  ///
  /// 搜索
  ///
  static Future<Map> search(int page, String key)async{
    var req = {
      'k':key
    };
//    return base(Api.search+'$page/json', req, type: HttpUtils.POST);
    Options baseOptions = Options(headers: {/*HttpHeaders.acceptHeader:"accept: application/json", HttpHeaders.contentTypeHeader:"application/json;charset=UTF-8",*/ "Cookie":""});
    Response  response = await Dio().post(Api.baseUrl+Api.search+'$page/json',data: req, options: baseOptions);
    return response.data;
  }

  ///
  /// post请求
  ///
  static Future<Map> testpost()async{
    var req = {
      'type':'android',
      'bundle_id':'000',
      'api_token':'000'
    };
    Options baseOptions = Options(headers: {HttpHeaders.acceptHeader:"accept: application/json", HttpHeaders.contentTypeHeader:"Content-Type: application/json"});
    Response  response = await Dio().post('http://api.fir.im/apps',data: req,options: baseOptions);
    print('结果： ------start-------');
    print(response.data);
    print('结果： ------end-------');
    return response.data;
  }
}