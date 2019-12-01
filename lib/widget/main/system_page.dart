import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/system_tree_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh_loadmore/flutter_refresh_loadmore.dart';
import 'package:enjoy_android/global/common.dart';
import '../../entity_factory.dart';
import '../web_widget.dart';


class SystemPage extends StatefulWidget {
  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {

  List<SystemTreeData> datas = new List();
  GlobalKey<ListViewRefreshLoadMoreWidgetState> _listViewKey = new GlobalKey();
  bool hasMoreData = false;

  @override
  void initState() {
    super.initState();
    _systemTree(true);
  }

  @override
  Widget build(BuildContext context) {
    return _systemTreeWidget();
  }

  _systemTree(bool isRefresh){
    if(isRefresh) {
      datas.clear();
    }
    ApiService.systemTree().then((json){
      SystemTreeEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        datas.addAll(entity.data);
        _listViewKey.currentState.changeData(datas.length,hasMoreData: hasMoreData);
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
      }
      return null;
    });
  }

  Widget _systemTreeWidget() {
    return ListViewRefreshLoadMoreWidget(
      key: _listViewKey,
      //listview  count
      itemCount: datas.length,

      //listview 的item widget
      swrapInsideWidget: (buildContex, index) {
        SystemTreeData item = datas[index];
        StringBuffer sub = StringBuffer('');
        item.children.forEach((child){
          sub.write(child.name);
          sub.write('    ');
        });
        return GestureDetector(
          onTap: (){
//            goTo(context, WebWidget(url: item.link,title: item.chapterName,));
          },
          child: Padding(padding: EdgeInsets.all(5),child: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 2),
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
      },
      //下拉刷新
      refrshCallback: () async {
        _systemTree(true);
      },
      //加载更多
      loadMoreCallback: () async {
        _systemTree(false);
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