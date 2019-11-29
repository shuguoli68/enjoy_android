
import 'package:enjoy_android/util/http_util.dart';

import '../entity_factory.dart';
import 'api.dart';

class ApiService{

  /**
   * 注册
   */
  static register(String username, String password)async{
    var json = await HttpUtils.request(
        Api.register,
        method: HttpUtils.POST,
        data: {
          'username':username,
          'password':password,
          'repassword':password
        }
    );
    return EntityFactory.generateOBJ(json);
  }

  /**
   * 登录
   */
  static Future login(String username, String password)async{
    var json = await HttpUtils.request(
        Api.login,
        method: HttpUtils.POST,
        data: {
          'username':username,
          'password':password
        }
    );
    return EntityFactory.generateOBJ(json);
  }

}