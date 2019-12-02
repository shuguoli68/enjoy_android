import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/navigate_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:flutter/material.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';
import '../web_widget.dart';


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
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text(data[index].name),
              ),
              ListView.builder(
                shrinkWrap: true, //解决无限高度问题
                physics:NeverScrollableScrollPhysics(),//禁用滑动事件
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int subIndex) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: Divider.createBorderSide(context,color: Colors.grey,width: 1)
                        )
                    ),
                    child: ListTile(
                      onTap: (){
                        goTo(context, WebWidget(url: data[index].articles[subIndex].link, title: data[index].articles[subIndex].title,));
                      },
                      title: Text(data[index].articles[subIndex].title),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  );
                },
                itemCount: data[index].articles.length,
              ),
            ],
          );
        },
        itemCount: data.length,
      ),
    );
  }

  void onLoading() {
  }
}