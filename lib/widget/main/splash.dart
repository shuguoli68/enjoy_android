import 'dart:async';

import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/sp_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Splash(),
          ),
        ),
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
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 1500),(){
      SharedPreferences sp = mySp();
      var isLogin = sp.getBool(SPKey.IS_LOGIN);
      if(isLogin){
        goToRm(context, MyMain());
      }else{
        goToRm(context, Login());
      }
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