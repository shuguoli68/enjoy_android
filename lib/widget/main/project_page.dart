import 'package:bot_toast/bot_toast.dart';
import 'package:enjoy_android/entity/project_entity.dart';
import 'package:enjoy_android/entity/project_tab_entity.dart';
import 'package:enjoy_android/global/api_service.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:flutter/material.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

import '../../entity_factory.dart';
import '../web_widget.dart';


class ProjectPage extends StatefulWidget {

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin{
  TabController _controller;//tab控制器
  int _currentIndex = 0; //选中下标

  List<ProData> _datas = new List();//tab集合
  List<DataX> _listDatas = new List();//内容集合
  ZekingRefreshController _refreshController;
  bool hasMoreData = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    print('initState');
    _getTabData();
    _refreshController = ZekingRefreshController();
  }

  ///
  /// tab改变监听
  ///
  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = _controller.index;
        page = 1;
      });
      print('_onTabChanged,$_currentIndex');
      _refreshController.refreshingWithLoadingView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _datas.isEmpty
        ?Center(child: Text('正在加载数据...'),)
        :DefaultTabController(
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
              tabs: _datas.map((ProData choice) {
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
              children: _datas.map((ProData item) {
                return ZekingRefresh(
                  controller: _refreshController,
                  onRefresh: onRefresh,
                  onLoading: onLoading,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(2),
                    itemBuilder: (BuildContext context, int index) {
                      return _projectSubWidget(index);
                    },
                    itemCount: _listDatas.length,
                  ),
                );
              }).toList(),
            ),
          ),
    );
  }

  _getTabData(){
    ApiService.projectTree().then((json){
      ProjectTabEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          _datas.addAll(entity.mData);
          _controller = TabController(initialIndex:0, length: _datas.length, vsync: this);
          _controller.addListener(() => _onTabChanged());
        });
        _refreshController.refreshingWithLoadingView();
      }else{//失败
        BotToast.showText(text: entity.errorMsg);
      }
      return null;
    });
  }

  onRefresh() {
    page = 1;
    _listDatas.clear();
    _projectSub(true, _datas[_currentIndex].id);
  }

  onLoading() {
    _projectSub(false, _datas[_currentIndex].id);
  }

  _projectSub(bool isRefresh, int id){
    ApiService.projectSub(page, id).then((json){
      ProjectEntity entity = EntityFactory.generateOBJ(json);
      if(entity.errorCode == 0){//成功
        setState(() {
          _listDatas.addAll(entity.pdata.datas);
          ++page;
        });
        List<DataX> mData = entity.pdata.datas;
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
      return null;
    });
  }

  Widget _projectSubWidget(int index) {
    DataX item = _listDatas[index];
    return GestureDetector(
      onTap: (){
        goTo(context, WebWidget(url: item.link,title: item.chapterName,));
      },
      child: Padding(padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Column(
          children: <Widget>[
            Flex(direction: Axis.horizontal,children: <Widget>[
              Container(width: 80, height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(image: NetworkImage(item.envelopePic),fit: BoxFit.cover)
                ),
              ),
              Expanded(flex:1, child: Padding(padding: EdgeInsets.only(left: 5),child: Text('简介：${item.desc}', style: TextStyle(fontSize: 16),maxLines: 3,),),)
            ],),
            Padding(padding: EdgeInsets.all(3)),
            Flex(direction: Axis.horizontal,children: <Widget>[
              Expanded(flex:1, child: Text('作者：${item.author}',style: TextStyle(color: Colors.black54),)),
              Expanded(flex:1, child: Text('分享于：${item.niceShareDate}',style: TextStyle(color: Colors.black54),)),
            ],)
          ],
        ),
      ),),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _refreshController.dispose();
  }
}