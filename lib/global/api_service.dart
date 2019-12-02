
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
      'cid' : cid
    };
    return base(Api.systemSub+'$page/json', req);
  }

  ///
  /// 导航数据
  ///
  static Future<Map> navigate()async{
    var req = {

    };
    return base(Api.navigate, req);
  }
}