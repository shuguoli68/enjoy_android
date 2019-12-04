import 'package:shared_preferences/shared_preferences.dart';

class SPKey{
  //主题
  static const String themeIndex = "themeIndex";
  //是否第一次进入
  static const String IS_FIRST = "IS_FIRST";
  //是否已登录
  static const String IS_LOGIN = "IS_LOGIN";


  static spSetStr(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static spGetStr(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String a = sp.getString(key);
    if(a==null) return "";
    return a;
  }

  static spSetBool(String key, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }

  static Future<bool> spGetBool(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool a = sp.getBool(key);
    if(a == null) return false;
    return a;
  }

  static spSetInt(String key, int value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(key, value);
  }

  static Future<int> spGetInt(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int a = sp.getInt(key);
    if(a == null) return 0;
    return a;
  }
}