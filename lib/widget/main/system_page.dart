import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/system_tree_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/widget/sub/system_sub.dart';
import 'package:flutter/material.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:zeking_refresh/zeking_refresh.dart';
import '../../entity_factory.dart';


class SystemPage extends StatefulWidget {
  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> with AutomaticKeepAliveClientMixin{

  List<SystemTreeData> datas = new List();
  ZekingRefreshController _refreshController;

  @override
  bool get wantKeepAlive => true;

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
        canLoadMore: false,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(2),
          itemBuilder: (BuildContext context, int index) {
            return _systemTreeWidget(index);
          },
          itemCount: datas.length,
        ),
      ),
    );
  }

  onRefresh() {
    _systemTree(true);
  }

  onLoading() {
    _systemTree(false);
  }

  _systemTree(bool isRefresh){
    if(isRefresh) {
      datas.clear();
    }
    ApiService.systemTree().then((json){
      SystemTreeEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        List<SystemTreeData> mData = entity.data;
        setState(() {
          datas.addAll(mData);
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

  Widget _systemTreeWidget(int index) {
    SystemTreeData item = datas[index];
    StringBuffer sub = StringBuffer('');
    item.children.forEach((child){
      sub.write(child.name);
      sub.write('    ');
    });
    return GestureDetector(
      onTap: (){
        goTo(context, SystemSub(data: item.children,));
      },
      child: Padding(padding: EdgeInsets.all(5),child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
//          border: Border.all(color: Colors.black12, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5), child: Text(item.name,style: TextStyle(fontSize: 18),),),
              Padding(padding: EdgeInsets.all(5), child: Text(sub.toString()),),
            ],
          ),
        ),
      ),),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }
}