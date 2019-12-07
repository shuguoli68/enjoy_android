import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/global/my_config.dart';
import 'package:enjoy_android/global/sp_key.dart';
import 'package:enjoy_android/global/theme_colors.dart';
import 'package:enjoy_android/global/theme_provide.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/widget/sub/score_rank.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'collect_list.dart';
import 'login.dart';


class HomeDrawer {

  BuildContext context;
  static String name = '点击头像登录';

  HomeDrawer(@required this.context);

  Widget _drawerHerder(){
    if(MyConfig.userName.isNotEmpty) name = MyConfig.userName;
    return UserAccountsDrawerHeader(
      accountName: Text(name),
      accountEmail: Text(name+'-email@163.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('images/user_ba.png'),
        child: GestureDetector(
          onTap: (){
            if(MyConfig.userName.isEmpty){
              goToRm(context, Login());
            }
          },
          child: Padding(padding: EdgeInsets.all(5),child: Text(MyConfig.userName.isNotEmpty?'':'未登录', style: TextStyle(color: Colors.red),),),
        ),
      ),
      onDetailsPressed: (){
        BotToast.showText(text:'点击了');
        print('点击');
      },
    );
  }

  void showThemeDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('切换主题'),
          content: SingleChildScrollView(
            child: Container(
              //包含ListView要指定宽高
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: THColors.themeColor.keys.length,
                itemBuilder: (BuildContext context, int position) {
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.only(bottom: 15),
                      color: THColors.themeColor[position]["primaryColor"],
                    ),
                    onTap: () async {
                      Provide.value<ThemeProvide>(context).setTheme(position);
                      //存储主题下标
                      SPKey.spSetInt(SPKey.themeIndex, position);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget homeDrawer(){
    return ListView(
      padding: EdgeInsets.all(0.0),
      children: <Widget>[

        _drawerHerder(),

        Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: Divider.createBorderSide(context,color: Colors.green,width: 1)
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text('藏'),),
            title: Text('收藏列表'),
            onTap: (){
              goTo(context, CollectList());
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: Divider.createBorderSide(context,color: Colors.green,width: 1)
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text('分'),),
            title: Text('积分排行榜'),
            onTap: (){
              goTo(context, ScoreRank());
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: Divider.createBorderSide(context,color: Colors.green,width: 1)
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text('切'),),
            title: Text('切换主题'),
            onTap: (){
              print('切换主题');
              showThemeDialog();
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: Divider.createBorderSide(context,color: Colors.green,width: 1)
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text('退'),),
            title: Text('退出登录'),
            onTap: (){
              logout(context);
            },
          ),
        ),

      ],
    );
  }
}