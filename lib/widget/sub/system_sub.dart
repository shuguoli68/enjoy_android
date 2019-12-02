import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/system_sub_entity.dart';
import 'package:enjoy_android/entity/system_tree_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh_loadmore/flutter_refresh_loadmore.dart';

import '../../entity_factory.dart';
import '../web_widget.dart';


class SystemSub extends StatefulWidget {
  List<SystemTreeDatachild> data;
  SystemSub({Key key,this.data}):super(key:key);
  @override
  State<SystemSub> createState() => _SystemSubState();
}

class _SystemSubState extends State<SystemSub> with SingleTickerProviderStateMixin{
  TabController _controller;//tab控制器
  int _currentIndex = 0; //选中下标

  List<SystemTreeDatachild> _datas ;//tab集合
  List<SystemSubDataData> _listDatas = new List<SystemSubDataData>();//内容集合

  GlobalKey<ListViewRefreshLoadMoreWidgetState> _listViewKey = new GlobalKey();
  bool hasMoreData = false;
  int page = 2;

  @override
  void initState() {
    super.initState();
    print('initState');
    _datas = widget.data;
    //初始化controller并添加监听
    _controller = TabController(length: _datas.length, vsync: this);
    _controller.addListener(() => _onTabChanged());
    _systemSub(true, _datas[_currentIndex].id);
  }

  ///
  /// tab改变监听
  ///
  _onTabChanged() {
    print('_onTabChanged,$_currentIndex');
    if (_controller.index.toDouble() == _controller.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = _controller.index;
        page = 0;
      });
      _systemSub(true, _datas[_currentIndex].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('知识体系'),),
      body: new DefaultTabController(
        length: _datas.length,
        child: new Scaffold(
          appBar: new TabBar(
            controller: _controller,//控制器
            labelColor: Colors.black, //选中的颜色
            labelStyle: TextStyle(fontSize: 16), //选中的样式
            unselectedLabelColor: Colors.black54, //未选中的颜色
            unselectedLabelStyle: TextStyle(fontSize: 14), //未选中的样式
            indicatorColor: Colors.green, //下划线颜色
            isScrollable: true, //是否可滑动
            tabs: _datas.map((SystemTreeDatachild choice) {
              return new Tab(
                text: choice.name,
              );
            }).toList(),
            //点击事件
            onTap: (int i) {
              print(i);
            },
          ),
          body: new TabBarView(
            controller: _controller,
            children: _datas.map((SystemTreeDatachild item) {
              return /*_systemSubWidget(item.id);*/ListView.builder(
                  itemCount: _listDatas.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Text(_listDatas[position].title);
                  });
            }).toList(),
          ),
        ),
      ),
    );
  }

  _systemSub(bool isRefresh, int id){
    if(isRefresh) {
      _listDatas.clear();
    }
    ApiService.systemSub(page, id).then((json){
      SystemSubEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          _listDatas.addAll(entity.data.datas);
//          _listViewKey.currentState.changeData(_listDatas.length,hasMoreData: hasMoreData);
          ++page;
        });
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
      }
      return null;
    });
  }

  Widget _systemSubWidget(int id) {
    return ListViewRefreshLoadMoreWidget(
      key: _listViewKey,
      //listview  count
      itemCount: _listDatas.length,

      //listview 的item widget
      swrapInsideWidget: (buildContex, index) {
        SystemSubDataData item = _listDatas[index];
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
        _systemSub(true, id);
      },
      //加载更多
      loadMoreCallback: () async {
        _systemSub(false, id);
      },
      /// 加载更多 用
      hasMoreData: hasMoreData,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}