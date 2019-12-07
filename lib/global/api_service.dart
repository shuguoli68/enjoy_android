
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enjoy_android/entity/register_entity.dart';
import 'package:enjoy_android/global/my_config.dart';
import 'package:enjoy_android/global/sp_key.dart';
import 'package:enjoy_android/util/http_util.dart';

import '../entity_factory.dart';
import 'api.dart';

class ApiService{

  static Map<String, String> _headerMap;

  static Map<String, String> _getHeader() {
    if (null == _headerMap) {
      _headerMap = Map();
      _headerMap["Cookie"] = MyConfig.cookie;
    }
    return _headerMap;
  }

  static Future<Map> base(String url, Map req,)async{
    var json = await HttpUtils.request(
        url,
        method: HttpUtils.GET,
        data: req,
        header: _headerMap,
    );
    return json;
  }

  static Future<Response> basePost(String url, {FormData req})async{
    var response;
    try {
      StringBuffer r = StringBuffer('{');
      for(int i = 0; i < req.fields.length; i++){
        r.write('"' + req.fields[i].key + '"');
        r.write(':"' + req.fields[i].value + '",');
      }
      r.write('}');
      print('post请求参数：' + r.toString());
      response = await Dio().post(Api.baseUrl + url, data: req, options: Options(headers: _getHeader()));
      print('post响应数据：' + response.toString());
    }on DioError catch (e) {
      /// 打印请求失败相关信息
      print('post请求出错：' + e.toString());
    }
    return response;
  }

  ///
  ///注册
  ///
  static Future<Response> register(String username, String password)async{
    FormData req = new FormData.fromMap({
      'username':username,
      'password':password,
      'repassword':password
    });
    return basePost(Api.register, req: req);
  }

  ///
  ///登录
  ///
  static Future<Response> login(String username, String password)async{
    FormData req = new FormData.fromMap({
      "username": "$username",
      "password": "$password",
    });
    return basePost(Api.login, req: req);
  }

  ///
  ///退出
  ///
  static Future<Map> logout()async{
    var req = {};
    return base(Api.logout, req);
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
  static Future<Response> search(int page, String key)async{
    FormData req = new FormData.fromMap({
      'k':key
    });
    return basePost(Api.search+'$page/json', req: req);
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

  ///
  /// 积分排行榜
  ///
  static Future<Map> scoreRank(int page)async{
    var req = {
    };
    return base(Api.scoreRank+'$page/json', req);
  }

  ///
  ///个人积分
  ///
  static Future<Response> myScore()async{
    FormData req = new FormData.fromMap({

    });
    return basePost(Api.myScore, req: req);
  }

  ///
  ///收藏文章
  ///
  static Future<Response> collect(int id)async{
    FormData req = new FormData.fromMap({

    });
    return basePost(Api.collect+'$id/json', req: req);
  }

  ///
  ///取消收藏文章
  ///
  static Future<Response> uncollect(int id)async{
    FormData req = new FormData.fromMap({

    });
    return basePost(Api.uncollect+'$id/json', req: req);
  }

  ///收藏文章列表
  ///
  static Future<Map> collectList(int page)async{
    var req = {
    };
    return base(Api.collectList+'$page/json', req);
  }

}