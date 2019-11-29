import 'package:enjoy_android/widget/main/register.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/util/http_util.dart';
import 'package:enjoy_android/global/api.dart';
import 'package:enjoy_android/entity/login_entity.dart';
import 'package:enjoy_android/entity_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/sp_key.dart';

import '../../main.dart';

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
      var json = await httpUtil.get(Api.login, options: {
        'username':username,
        'password':password
      });
      LoginEntity loginEntity = EntityFactory.generateOBJ(json);
      SharedPreferences sp = mySp();
      if(loginEntity.errorCode == 0){//登录成功
        sp.setBool(SPKey.IS_LOGIN, true);
        goToRm(context, MyMain());
      }else{//登录失败
        BotToast.showText(text: loginEntity.errorMsg);
        sp.setBool(SPKey.IS_LOGIN, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            TextField(
              controller: controller1,
              decoration: InputDecoration(
                icon: Icon(Icons.accessibility),
                labelText: '用户名：',
                helperText: '用户名应少于6个字符',
                hintText: '请输入用户名',
                prefixIcon: Icon(Icons.account_box),
                suffixIcon: Icon(Icons.clear,),
              ),
            ),

            TextField(
              controller: controller1,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                labelText: '密码：',
                helperText: '密码应少于6个字符',
                hintText: '请输入密码',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),

            MaterialButton(
              child: Text('登录'),
              onPressed: (){
                _doLogin();
              },
            ),

            MaterialButton(
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
    );
  }
}