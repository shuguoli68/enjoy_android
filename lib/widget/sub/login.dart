import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/my_config.dart';
import 'package:enjoy_android/widget/sub/register.dart';
import 'package:flutter/material.dart';
import 'package:enjoy_android/util/http_util.dart';
import 'package:enjoy_android/global/api.dart';
import 'package:enjoy_android/entity/login_entity.dart';
import 'package:enjoy_android/entity_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/sp_key.dart';

import '../main/home.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  GlobalKey _globalKey = GlobalKey<FormState>();


  _doLogin() async {
    String username = controller1.text;
    String password = controller2.text;
    if(username.isEmpty){
      myToast('账号不能为空');
    }else if(password.isEmpty){
      myToast('密码不能为空');
    }else{
      ApiService.login(username, password).then<Response>((response){
        LoginEntity loginEntity = EntityFactory.generateOBJ(response.data);
        if(loginEntity.errorCode == 0){//登录成功
          print('登录成功');
          String cookie = "";
          response.headers.forEach((String name, List<String> values) {
            if (name == "set-cookie") {
              cookie = json
                  .encode(values)
                  .replaceAll("\[\"", "")
                  .replaceAll("\"\]", "")
                  .replaceAll("\",\"", "; ");
            }
          });
          print('cookie:$cookie');
          SPKey.spSetStr(SPKey.USER_NAME, username);
          SPKey.spSetStr(SPKey.PASS_WORD, password);
          SPKey.spSetStr(SPKey.COOKIE, cookie);
          SPKey.spSetBool(SPKey.IS_LOGIN, true);
          MyConfig.userName = username;
          MyConfig.isLogin = true;
          MyConfig.cookie = cookie;
          goToRm(context, Home());
        }else{//登录失败
          print('登录失败：'+loginEntity.errorMsg);
          myToast(loginEntity.errorMsg);
        }
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: true,//输入框抵住键盘
      body: Center(
        child: SingleChildScrollView(
          child: Container(
//            color: Colors.white,
            padding: EdgeInsets.only(left: 30,right: 30),
            child: Form(
              key: _globalKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[

                  Text('登录到`玩Android`',style: TextStyle(fontSize: 24),),

                  Padding(padding: EdgeInsets.only(top: 30)),

                  TextFormField(
                    controller: controller1,
                    decoration: InputDecoration(
                      labelText: '账号：',
//                      helperText: '账号长度至少3位！',
                      hintText: '请输入账号',
                      prefixIcon: Icon(Icons.account_box),
                    ),
                      validator: (v) {
                        return v.trim().length >= 3 ? null : "账号长度至少3位！";
                      }
                  ),

                  TextFormField(
                    controller: controller2,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '密码：',
//                      helperText: '密码长度至少6位！',
                      hintText: '请输入密码',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                      validator: (v) {
                        return v.trim().length >= 6 ? null : "密码长度至少6位！";
                      }
                  ),

                  Padding(padding: EdgeInsets.only(top: 30)),

                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.green,
                    child: Text('登录'),
                    onPressed: (){
                      _doLogin();
                    },
                  ),

                  Padding(padding: EdgeInsets.only(top: 20)),

                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.green,
                    child: Text('还没账号？去注册'),
                    onPressed: (){
                      Navigator
                          .of(context).push(MaterialPageRoute(builder: (_)=> Register()))
                          .then((onValue){
                        if(onValue == null) return;
                        Map<String,String> map = onValue;
                        String txt1 = map['username'];
                        String txt2 = map['password'];
                        if(txt1.isNotEmpty) {
                          controller1.text = txt1;
                          if (txt2.isNotEmpty) {
                            controller2.text = txt2;
                            _doLogin();
                            myToast( '正在登录...');
                          }
                        }
                      });
                    },
                  ),

                  Padding(padding: EdgeInsets.only(top: 20)),

                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.green,
                    child: Text('游客进入'),
                    onPressed: (){
                      goToRm(context, Home());
                    },
                  ),

                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}