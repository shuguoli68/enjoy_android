import 'dart:convert';

import 'package:banner/banner.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/home_banner_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/widget/web_widget.dart';
import 'package:flutter/material.dart';

import '../../entity_factory.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<HomeBannerData> bannerData;

  @override
  void initState() {
    super.initState();
    _banner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            _bannerWidget(),

          ],
        ),
      )
    );
  }

  _banner(){
    ApiService.banner().then((json){
      HomeBannerEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          bannerData = entity.data;
        });
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
      }
      return null;
    });
  }

  _bannerWidget() {
    return Container(
      padding: EdgeInsets.all(10.0),
//      decoration: BoxDecoration(
//        border: Border.all(color: Colors.amber, width: 1),
//        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//      ),
      child: BannerView(
        data: bannerData,
        buildShowView: (index,data) {
          HomeBannerData item = data;
          return Flex(direction: Axis.vertical,children: <Widget>[
            Expanded(flex:1, child: Image.network(item.imagePath, width: double.infinity,fit: BoxFit.fitWidth,),),
            Container(padding:EdgeInsets.only(left: 10,right: 10),child: Flex(direction: Axis.horizontal,children: <Widget>[
              Expanded(flex:1, child: Text(item.title),),
              Text('${item.order+1}/${bannerData.length}'),
            ],),)
          ],);
        },
        onBannerClickListener: (index,data){
          HomeBannerData item = data;
          goTo(context, WebWidget(url: item.url,title: item.title,));
        },
        height: 200.0,
      ),);
  }
}