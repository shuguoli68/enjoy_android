import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();


  _doLogin(){
    String username = controller1.text;
    String password = controller2.text;
    if(username.isEmpty){
      BotToast.showText(text: '账号不能为空');
    }else if(password.isEmpty){
      BotToast.showText(text: '密码不能为空');
    }else{

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

          ],
        ),
      ),
    );
  }
}