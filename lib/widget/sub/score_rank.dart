import 'package:enjoy_android/entity/score_rank_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:flutter/material.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';

class ScoreRank extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ScoreRankState();
}

class _ScoreRankState extends State<ScoreRank> {

  List<SRDataX> datas = List();
  ZekingRefreshController _refreshController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _refreshController = ZekingRefreshController();
    _refreshController.refreshingWithLoadingView();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(baseBg),
      appBar: AppBar(
        title: Text('积分排行榜'),
      ),
      body: ZekingRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.builder(
          padding: EdgeInsets.all(2),
          itemBuilder: (BuildContext context, int index) {
            return _itemWidget(index);
          },
          itemCount: datas.length,
        ),
      ),
    );
  }

  onRefresh() {
    page = 1;
    datas.clear();
    _reqData(true);
//    _myScore();
  }

  onLoading() {
    _reqData(false);
  }

  void _myScore() {
    ApiService.myScore().then((json) {
      ScoreRankEntity entity = EntityFactory.generateOBJ(json.data);
      if (entity.errorCode == 0) { //成功
      }
      else {

      }
    });
  }

  _reqData(bool isRefresh){
    ApiService.scoreRank(page).then((json){
      ScoreRankEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          datas.addAll(entity.data.datas);
          ++page;
        });
        List<SRDataX> mData = entity.data.datas;
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
        myToast(entity.errorMsg);
        if(isRefresh){
          _refreshController.refreshFaild();
        }else{
          _refreshController.loadMoreFailed();
        }
      }
      return null;
    });
  }

  Widget _itemWidget(int index) {
    SRDataX item = datas[index];
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: <Widget>[
          Flex(direction: Axis.horizontal,children: <Widget>[
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text((index+1).toString()),)),
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text('等级：${item.level}'),)),
          ],),

          Flex(direction: Axis.horizontal,children: <Widget>[
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text(item.username),)),
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text('积分：${item.coinCount}'),)),
          ],),
        ],
      ),
    );
  }

}