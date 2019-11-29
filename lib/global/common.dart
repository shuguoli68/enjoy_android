import 'package:flutter/material.dart';
import 'package:enjoy_android/global/my_public.dart';
import 'package:shared_preferences/shared_preferences.dart';

myToast(String s){
  BotToast.showText(text: s);
}

spSetStr(String key, String value) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(key, value);
}

spGetStr(String key) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  String a = sp.getString(key);
  if(a==null) return "";
  return a;
}

spSetBool(String key, bool value) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool(key, value);
}

Future<bool> spGetBool(String key) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool a = sp.getBool(key);
  if(a == null) return false;
  return a;
}

goTo(BuildContext context, Widget key){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return key;
  }));
}

goToRm(BuildContext context, Widget key){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_){
    return key;
  }), (route) => route == null);
}

goPop(BuildContext context, Map key){
  Navigator.of(context).pop(key);
}

numStr(int count){
  if(count<11000){
    return count.toString();
  }else if(count<10000*100){
    return (count/10000.0).toStringAsFixed(2)+'万';
  }else{
    return (count/10000.0).toStringAsFixed(1)+'万';
  }
}
