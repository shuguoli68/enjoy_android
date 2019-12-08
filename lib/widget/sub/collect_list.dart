import 'package:enjoy_android/entity/collect_lg_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:flutter/material.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';

class CollectList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CollectListState();
}

class _CollectListState extends State<CollectList> {

  List<CLDataX> datas = List();
  ZekingRefreshController _refreshController;
  int page = 0;

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
        title: Text('收藏列表'),
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

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  onRefresh() {
    page = 0;
    datas.clear();
    _reqData(true);
  }

  onLoading() {
    _reqData(false);
  }

  _reqData(bool isRefresh){
    ApiService.collectList(page).then((json){
      CollectLgEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          datas.addAll(entity.data.datas);
          ++page;
        });
        List<CLDataX> mData = entity.data.datas;
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
    CLDataX item = datas[index];
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: <Widget>[

          Padding(padding: EdgeInsets.all(5), child: Text(item.desc.isEmpty?item.title:item.desc)),

          Flex(direction: Axis.horizontal,children: <Widget>[
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text('浏览数  ${item.visible}'),)),
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text('点赞  ${item.zan}'),)),
          ],),

          Flex(direction: Axis.horizontal,children: <Widget>[
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text('作者：${item.author}'),)),
            Expanded(flex:1,child: Padding(padding: EdgeInsets.all(5), child: Text('分享于：${item.niceDate}'),)),
          ],),
        ],
      ),
    );
  }

}