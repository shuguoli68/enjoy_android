import 'dart:async';

import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/sp_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../main.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Splash(),
            ),
          ),
        ),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Timer timer;

  @override
  void initState(){
    super.initState();
    timer = Timer(const Duration(milliseconds: 1500),(){
      Future isLogin = spGetBool(SPKey.IS_LOGIN);
      isLogin.then((onValue){
        if(onValue){
          goToRm(context, MyMain());
        }else{
          goToRm(context, Login());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Scaffold(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    timer = null;
  }
}