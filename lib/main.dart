

import 'dart:async';

import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/my_config.dart';
import 'package:enjoy_android/widget/main/home.dart';
import 'package:enjoy_android/widget/sub/login.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provide/provide.dart';

import 'global/sp_key.dart';
import 'global/theme_colors.dart';
import 'global/theme_provide.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    timer = Timer(const Duration(milliseconds: 100),(){
      _initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('images/splash.jpg',width: double.infinity, height: double.infinity,fit: BoxFit.fill,),
    );
  }

  _initData(){
    Future.wait([
      SPKey.spGetStr(SPKey.COOKIE).then((onValue){
        MyConfig.cookie = onValue;
      }),
      SPKey.spGetStr(SPKey.USER_NAME).then((value){
        if(value.isNotEmpty){
          MyConfig.userName = value;
        }
      }),
      SPKey.spGetBool(SPKey.IS_LOGIN).then((onValue){
        MyConfig.isLogin = onValue;
      })
    ]).then((value){
      print('结果：$value');
    }).whenComplete((){
      if(MyConfig.isLogin){
        goToRm(context, Home());
      }else{
        goToRm(context, Login());
//          goToRm(context, Home());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    timer = null;
  }
}