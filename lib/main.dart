

import 'dart:async';

import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/sp_key.dart';
import 'package:enjoy_android/widget/main/home.dart';
import 'package:enjoy_android/widget/sub/login.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provide/provide.dart';

import 'global/theme_colors.dart';
import 'global/theme_provide.dart';


void main() {
  var providers = Providers();

  providers.provide(Provider.function((context)=> ThemeProvide()));

  int themeIndex;
  SPKey.spGetInt(SPKey.themeIndex).then((onValue){
    print('theme:$themeIndex, $onValue');
    themeIndex = onValue;
  });
  themeIndex =  null == themeIndex ? 0 : themeIndex;
  runApp(ProviderNode(child: MyApp(themeIndex), providers: providers));
}

class MyApp extends StatelessWidget {
  int themeIndex;

  MyApp(this.themeIndex);

  _themeColor(ThemeProvide theme, String type){
    return THColors.themeColor[theme.value != null ? theme.value: themeIndex][type];
  }
  @override
  Widget build(BuildContext context) {
    return Provide<ThemeProvide>(
      builder: (context,child,theme){
        return BotToastInit(
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: _themeColor(theme,'primaryColor'),
              primaryColorDark: _themeColor(theme,'colorPrimaryDark'),
              primaryColorLight: _themeColor(theme,'colorPrimaryLight'),
              accentColor:  _themeColor(theme,'colorAccent'),
            ),
            debugShowCheckedModeBanner: false,
            home: Splash(),
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
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
      Future isLogin = SPKey.spGetBool(SPKey.IS_LOGIN);
      isLogin.then((onValue){
        if(onValue){
          goToRm(context, Home());
        }else{
//          goToRm(context, Login());
          goToRm(context, Home());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Splash'),
//      ),
      body: Scaffold(
        body: Center(
          child: Image.asset('images/splash.png',fit: BoxFit.fill,),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    timer = null;
  }
}