import 'package:enjoy_android/entity/register_entity.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/util/http_util.dart';
import 'package:enjoy_android/global/api.dart';
import 'package:enjoy_android/entity_factory.dart';
import 'package:enjoy_android/global/common.dart';


class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Register();
}

class _Register extends State<Register> {

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();


  _doRegister() async {
    String username = controller1.text;
    String password = controller2.text;
    String repassword = controller3.text;
    if(username.isEmpty){
      BotToast.showText(text: '账号不能为空');
    }else if(password.isEmpty){
      BotToast.showText(text: '密码不能为空');
    }else if(repassword.isEmpty){
      BotToast.showText(text: '重复密码不能为空');
    }else{
      if(password != repassword){
        BotToast.showText(text: '两次输入的密码不一致');
        return;
      }
      var json = await httpUtil.get(Api.register, options: {
        'username':username,
        'password':password,
        'repassword':repassword
      });
      RegisterEntity registerEntity = EntityFactory.generateOBJ(json);
      if(registerEntity.errorCode == 0){//注册成功
        Map<String,String> map = {
          'username':username,
          'password':password
        };
        goPop(context, map);
      }else{//注册失败
        BotToast.showText(text: registerEntity.errorMsg);
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

            TextField(
              controller: controller3,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                labelText: '密码：',
                helperText: '密码应少于6个字符',
                hintText: '请再次输入密码',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),

            MaterialButton(
              child: Text('注册'),
              onPressed: (){
                _doRegister();
              },
            ),

            MaterialButton(
              child: Text('已有账号？去登录'),
              onPressed: (){
                goPop(context, null);
              },
            ),

          ],
        ),
      ),
    );
  }
}