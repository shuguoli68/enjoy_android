import 'dart:convert';

import 'package:banner/banner.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/home_article_entity.dart';
import 'package:enjoy_android/entity/home_banner_entity.dart';
import 'package:enjoy_android/entity/logout_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/global/my_config.dart';
import 'package:enjoy_android/util/db/article_bean.dart';
import 'package:enjoy_android/util/db/article_provider.dart';
import 'package:enjoy_android/widget/web_widget.dart';
import 'package:flutter/material.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ZekingRefreshController _refreshController;
  List<HomeBannerData> bannerData = new List();
  List<HomeArticleDataData> datas = new List();
  bool hasMoreData = true;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = ZekingRefreshController();
    _refreshController.refreshingWithLoadingView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseBg),
      body: ZekingRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(2),
          itemBuilder: (BuildContext context, int index) {
            if(index == 0){
              return Column(children: <Widget>[
                _bannerWidget(),
                _articleWidget(index),
              ],);
            }else {
              return _articleWidget(index);
            }
          },
          itemCount: datas.length,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  onRefresh() {
    _banner();
    _article(true);
  }

  onLoading() {
    _article(false);
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
        List<HomeArticleDataData> mData = entity.data.datas;
        setState(() {
          datas.addAll(mData);
          ++page;
        });
        if(isRefresh){
          if(mData.isNotEmpty)
            _refreshController.refreshSuccess();
          else
            _refreshController.refreshEmpty();
        }else{
          if(mData.isNotEmpty)
            _refreshController.loadMoreSuccess();
          else
            _refreshController.loadMoreNoMore();
        }
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
        if(isRefresh){
          _refreshController.refreshFaild();
        }else{
          _refreshController.loadMoreFailed();
        }
      }
      return ;
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

  Widget _articleWidget(int index) {
    HomeArticleDataData item = datas[index];
    return GestureDetector(
      onTap: (){
//        goTo(context, WebWidget(url: item.link,title: item.chapterName,));
      ApiService.collectList(0).then((value){

      });
      },
      child: Padding(padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
//          border: Border.all(color: Colors.black12, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Column(
          children: <Widget>[
            Flex(direction: Axis.horizontal,children: <Widget>[
              ClipOval(
                child: Image.asset('images/default.png',width: 50,height: 50,fit: BoxFit.fitHeight,),
              ),
              Expanded(flex:1, child: Padding(padding: EdgeInsets.only(left: 5),child: Text(item.title, style: TextStyle(fontSize: 16),maxLines: 3,),),),
              IconButton(icon: Icon(item.collect?Icons.favorite:Icons.favorite_border,color: Colors.red,), onPressed: (){
                MyConfig.isLogin?_collect(item):_saveDB(item);
              }),
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
  }

  _collect(HomeArticleDataData item){
    if(item.collect){//取消收藏
      ApiService.uncollect(item.id).then((json){
        LogoutEntity entity = EntityFactory.generateOBJ(json.data);
        if(entity.errorCode == 0){//成功
          setState(() {
            item.collect = !item.collect;
          });
          myToast('已取消收藏');
        }else{//失败
          myToast(entity.errorMsg);
        }
      });
    }else{//收藏
      ApiService.collect(item.id).then((json){
        LogoutEntity entity = EntityFactory.generateOBJ(json.data);
        if(entity.errorCode == 0){//成功
          setState(() {
            item.collect = !item.collect;
          });
          myToast('已收藏');
        }else{//失败
          myToast(entity.errorMsg);
        }
      });
    }
  }

  _saveDB(HomeArticleDataData item){
    if(!item.collect){
      ArticleBean model = new ArticleBean(id: item.id, title: item.title, upTime: item.niceShareDate, author: item.author.isEmpty?'未知':item.author, link: item.link);
      saveArticle(model);
      setState(() {
        item.collect = true;
      });
      myToast('已保存至本地收藏');
    }
  }
}