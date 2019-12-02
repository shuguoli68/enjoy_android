import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/navigate_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:flutter/material.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';


class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ZekingRefreshController _refreshController;

  List<NaviData> data = new List();
  int addIndex = 1;

  @override
  void initState() {
    super.initState();
    _refreshController = ZekingRefreshController();
    _refreshController.refreshingWithLoadingView();
  }

  _reqData(){
    ApiService.navigate().then((json){
      NavigateEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          BotToast.showText(text: entity.errorMsg);
          data.clear();
          data.addAll(entity.mData);
        });
        if(entity.mData.isNotEmpty)
          _refreshController.refreshSuccess();
        else
          _refreshController.refreshEmpty();
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
        _refreshController.refreshFaild();
      }
      return ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZekingRefresh(
      controller: _refreshController,
      onRefresh: _reqData,
      onLoading: onLoading,
      canLoadMore: false,
      canRefresh: true,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return Text(data[index].name);
        },
        itemCount: data.length,
      ),
    );
  }

  void onLoading() {
  }
}