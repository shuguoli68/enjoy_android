import 'package:enjoy_android/global/common.dart';
import 'package:enjoy_android/util/db/article_bean.dart';
import 'package:enjoy_android/util/db/article_provider.dart';
import 'package:enjoy_android/widget/web_widget.dart';
import 'package:flutter/material.dart';
import 'package:zeking_refresh/zeking_refresh.dart';


class CollectLocal extends StatefulWidget {
  @override
  State<CollectLocal> createState() => _CollectLocalState();
}

class _CollectLocalState extends State<CollectLocal> {
  List<ArticleBean> datas = List();
  ArticleProvider _provider;
  ZekingRefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = ZekingRefreshController();
    _refreshController.refreshingWithLoadingView();
    _provider = new ArticleProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本地收藏'),
      ),
      body: ZekingRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        canLoadMore: false,
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
    datas.clear();
    _reqData(true);
  }

  onLoading() {
    _reqData(false);
  }

  _reqData(bool isRefresh){
    _provider.getArticleList().then<List<ArticleBean>>((list){
      setState(() {
        datas.addAll(list);
      });
      if(isRefresh){
        if(list.isNotEmpty)
          _refreshController.refreshSuccess();
        else
          _refreshController.refreshEmpty();
      }
      return;
    });
  }

  Widget _itemWidget(int index) {
    ArticleBean item = datas[index];
    return GestureDetector(
      onTap: (){
        goTo(context, WebWidget(url: item.link,title: item.title,));
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
              Expanded(flex:1, child: Padding(padding: EdgeInsets.only(left: 5),child: Text(item.title, style: TextStyle(fontSize: 16),maxLines: 3,),),),
              IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){
                setState(() {
                  _provider.delete(item.id);
                  datas.remove(item);
                });
              })
            ],),
            Padding(padding: EdgeInsets.all(3)),
            Flex(direction: Axis.horizontal,children: <Widget>[
              Expanded(flex:1, child: Text(item.author,style: TextStyle(color: Colors.black54),)),
              Expanded(flex:1, child: Text(item.upTime,style: TextStyle(color: Colors.black54),)),
            ],)
          ],
        ),
      ),),
    );
  }
}