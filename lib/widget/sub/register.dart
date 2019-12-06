import 'package:dio/dio.dart';
import 'package:enjoy_android/entity/register_entity.dart';
import 'package:enjoy_android/global/api.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/util/http_util.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:flutter/services.dart';

import '../../entity_factory.dart';


class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Register();
}

class _Register extends State<Register> {

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  GlobalKey _globalKey = GlobalKey<FormState>();


  _doRegister() async {
    String username = controller1.text;
    String password = controller2.text;
    String repassword = controller3.text;
    if(password != repassword){
      BotToast.showText(text: '两次输入的密码不一致');
      return;
    }
    if((_globalKey.currentState as FormState).validate()){
      ApiService.register(username, password).then<Response>((json){
        RegisterEntity registerEntity = EntityFactory.generateOBJ(json.data);
        if(registerEntity.errorCode == 0){//注册成功
          print('注册成功');
          Map<String,String> map = {
            'username':username,
            'password':password
          };
          goPop(context, map);
        }else{//注册失败
          BotToast.showText(text: registerEntity.errorMsg);
        }
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: Form(
              key: _globalKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[

                  Text('注册新账号',style: TextStyle(fontSize: 24),),

                  Padding(padding: EdgeInsets.only(top: 30)),

                  TextFormField(
                    controller: controller1,
                    decoration: InputDecoration(
                      labelText: '账号：',
                      helperText: '账号长度至少3位！',
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
                      helperText: '密码长度至少6位！',
                      hintText: '请输入密码',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      return v.trim().length >= 6 ? null : "密码长度至少6位！";
                    }
                  ),

                  TextFormField(
                    controller: controller3,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '密码：',
                      helperText: '密码长度至少6位！',
                      hintText: '请再次输入密码',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      return v.trim().length >= 6 ? null : "密码长度至少6位！";
                    }
                  ),

                  Padding(padding: EdgeInsets.only(top: 10)),

                  MaterialButton(
                    color: Colors.green,
                    minWidth: double.infinity,
                    child: Text('注册'),
                    onPressed: (){
                      _doRegister();
                    },
                  ),

                  Padding(padding: EdgeInsets.only(top: 20)),

                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.green,
                    child: Text('已有账号？去登录'),
                    onPressed: (){
                      goPop(context, null);
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