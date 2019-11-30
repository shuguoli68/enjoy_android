import 'package:dio/dio.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/widget/sub/register.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
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


  _doLogin() async {
    String username = controller1.text;
    String password = controller2.text;
    if(username.isEmpty){
      BotToast.showText(text: '账号不能为空');
    }else if(password.isEmpty){
      BotToast.showText(text: '密码不能为空');
    }else{

      ApiService.login(username, password).then<Map>((json){
        LoginEntity loginEntity = EntityFactory.generateOBJ(json);
        if(loginEntity.errorCode == 0){//登录成功
          spSetBool(SPKey.IS_LOGIN, true);
          goToRm(context, Home());
        }else{//登录失败
          print('登录失败：'+loginEntity.errorMsg);
          BotToast.showText(text: loginEntity.errorMsg);
          spSetBool(SPKey.IS_LOGIN, false);
        }
        return null;
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
            color: Colors.white,
            padding: EdgeInsets.only(top: 100.0,left: 30,right: 30),
            child: Column(
              children: <Widget>[

                Text('登录到`玩Android`',style: TextStyle(fontSize: 24),),

                Padding(padding: EdgeInsets.only(top: 30)),

                TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    labelText: '用户名：',
                    helperText: '用户名应少于6个字符',
                    hintText: '请输入用户名',
                    prefixIcon: Icon(Icons.account_box),
                  ),
                ),

                TextField(
                  controller: controller2,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '密码：',
                    helperText: '密码应少于6个字符',
                    hintText: '请输入密码',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),

                MaterialButton(
                  color: Colors.green,
                  child: Text('登录'),
                  onPressed: (){
                    _doLogin();
                  },
                ),

                MaterialButton(
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
                          BotToast.showText(text: '正在登录...');
                        }
                      }
                    });
                  },
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
}