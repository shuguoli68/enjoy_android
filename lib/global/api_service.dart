
import 'package:enjoy_android/entity/register_entity.dart';
import 'package:enjoy_android/util/http_util.dart';

import '../entity_factory.dart';
import 'api.dart';

class ApiService{

  static Future<Map> base(String url, Map req, {String type})async{
    var json = await HttpUtils.request(
        url,
        method: type==null||type.isEmpty?HttpUtils.POST:type,
        data: req
    );
    return json;
  }

  /**
   * 注册
   */
  static Future<Map> register(String username, String password)async{
    var req = {
      'username':username,
      'password':password,
      'repassword':password
    };
    return base(Api.register, req);
  }

  /**
   * 登录
   */
  static Future<Map> login(String username, String password)async{
    var req = {
      'username':username,
      'password':password
    };
    return base(Api.login, req);
  }

  /**
   * 首页banner
   */
  static Future<Map> banner()async{
    var req = {
    };
    return base(Api.banner, req, type: HttpUtils.GET);
  }

  /**
   * 首页文章列表
   */
  static Future<Map> homeArticle(int page)async{
    var req = {
    };
    return base(Api.article+'$page/json', req, type: HttpUtils.GET);
  }

  /**
   * 体系数据
   */
  static Future<Map> systemTree()async{
    var req = {
    };
    return base(Api.systemTree, req, type: HttpUtils.GET);
  }
}