import 'dart:convert';

import 'package:banner/banner.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/home_article_entity.dart';
import 'package:enjoy_android/entity/home_banner_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/widget/web_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh_loadmore/flutter_refresh_loadmore.dart';

import '../../entity_factory.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<HomeBannerData> bannerData = new List();
  List<HomeArticleDataData> datas = new List();
  GlobalKey<ListViewRefreshLoadMoreWidgetState> _listViewKey = new GlobalKey();
  bool hasMoreData = true;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _banner();
    _article(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
//        child: Column(
          children: <Widget>[
            _bannerWidget(),
            Expanded(flex:1, child: _articleWidget(),)
          ],
//        ),
      )
    );
  }

  _banner(){
    ApiService.banner().then((json){
      HomeBannerEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          bannerData.clear();
          bannerData.addAll(entity.data);
        });
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
      }
      return null;
    });
  }

  _article(bool isRefresh){
    if(isRefresh) {
      page = 0;
      datas.clear();
    }
    ApiService.homeArticle(page).then((json){
      HomeArticleEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        datas.addAll(entity.data.datas);
        _listViewKey.currentState.changeData(datas.length,hasMoreData: hasMoreData);
        ++page;
//        setState(() {
//
//        });
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

  Widget _articleWidget() {
    return ListViewRefreshLoadMoreWidget(
      key: _listViewKey,
      //listview  count
      itemCount: datas.length,

      //listview 的item widget
      swrapInsideWidget: (buildContex, index) {
        HomeArticleDataData item = datas[index];
        return GestureDetector(
          onTap: (){
            goTo(context, WebWidget(url: item.link,title: item.chapterName,));
          },
          child: Padding(padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),child: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(
              children: <Widget>[
                Flex(direction: Axis.horizontal,children: <Widget>[
                  ClipOval(
                    child: Image.asset('images/default.png',width: 50,height: 50,fit: BoxFit.fitHeight,),
                  ),
                  Expanded(flex:1, child: Padding(padding: EdgeInsets.only(left: 5),child: Text(item.title, style: TextStyle(fontSize: 16),maxLines: 3,),),)
                ],),
                Padding(padding: EdgeInsets.all(3)),
                Flex(direction: Axis.horizontal,children: <Widget>[
                  Expanded(flex:1, child: Text(item.chapterName,style: TextStyle(color: Colors.black54),)),
                  Expanded(flex:1, child: Text(item.niceShareDate,style: TextStyle(color: Colors.black54),)),
                ],)
              ],
            ),
          ),),
        );
      },
      //下拉刷新
      refrshCallback: () async {
        _article(true);
      },
      //加载更多
      loadMoreCallback: () async {
        _article(false);
      },

      /// 加载更多 用
      hasMoreData: hasMoreData,
      //    ///footer widget 非必须传有默认
      //    footerWidget: (statusStr){
      //      return null;
      //    },
      //    //head widget 非必传有默认
//          headWidget: (headstate,currentHeight){
//          return _bannerWidget();
//          ;
//          },
    );
  }
}