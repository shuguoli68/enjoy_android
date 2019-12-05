import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/hot_word_entity.dart';
import 'package:enjoy_android/entity/search_result_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:flutter/material.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';
import '../web_widget.dart';

class SearchHot extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SearchHotState();
}

class _SearchHotState extends State<SearchHot> {

  List<HotData> hotData = List();
  List<RDataX> datas = List();
  ZekingRefreshController _refreshController = ZekingRefreshController();
  int page = 0;
  String keyWord = '';

  @override
  void initState() {
    super.initState();
    _reqHot();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white70,
          child: Column(
            children: <Widget>[

              Container(
                color: Colors.white,
                child: TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: '请输入关键字...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: ((value){
                    _reqData(value);
                  }),
                  onSubmitted: ((value){
                    _reqData(value);
                  }),
                ),
              ),

              _resultWidget(),

            ],
          ),
        ),
      ),
    );
  }

  _reqHot(){
    hotData.clear();
    ApiService.hotword().then((json){
      HotwordEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          hotData.addAll(entity.data);
        });
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
      }
      return ;
    });
  }

  _reqData(String key){
    keyWord = key;
    ApiService.search(page, key).then((json){
      SearchResultEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        List<RDataX> mData = entity.data.datas;
        setState(() {
          datas.addAll(mData);
        });
        if(mData.isNotEmpty) {
          ++page;
          _refreshController.loadMoreSuccess();
        }
        else
          _refreshController.loadMoreNoMore();
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
        _refreshController.loadMoreFailed();
      }
      return ;
    });
  }

  onLoading() {
    _reqData(keyWord);
  }

  _resultWidget(){
    if(datas.isEmpty){
      return Column(children: <Widget>[
        Row(children: <Widget>[ Expanded(child: Padding(padding: EdgeInsets.only(left: 10,top: 30,bottom: 10),child: Text('热门搜索：',textAlign: TextAlign.left,),),) ],),
        Wrap(spacing: 5, runSpacing: 5, children: _hotWidget(),)
      ],);
    }else{
      return ZekingRefresh(
        controller: _refreshController,
        canRefresh: false,
        onLoading: onLoading,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(2),
          itemBuilder: (BuildContext context, int index) {
            return _itemWidget(index);
          },
          itemCount: datas.length,
        ),
      );
    }
  }

  _itemWidget(int index){
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Padding(padding: EdgeInsets.all(5), child: Text(datas[index].niceShareDate),),
        Padding(padding: EdgeInsets.all(5), child: Text(datas[index].title),),
      ],),
    );
  }

  _hotWidget() {
    return List.generate(hotData.length, (subIndex) {
      return GestureDetector(
        onTap: (){
          goTo(context, WebWidget(url: hotData[subIndex].link, title: hotData[subIndex].name,));
        },
        child: Chip(
          label: Text(hotData[subIndex].name),
          avatar: CircleAvatar(
            backgroundColor: Color(0xfff1f1f1),
            child: Text(hotData[subIndex].name.substring(0,1).isEmpty?"C":hotData[subIndex].name.substring(0,1),style: TextStyle(fontSize: 12.0),),
          ),
        ),
      );
    });
  }
}
