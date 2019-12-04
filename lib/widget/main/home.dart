import 'package:enjoy_android/widget/main/home_page.dart';
import 'package:enjoy_android/widget/main/project_page.dart';
import 'package:enjoy_android/widget/main/search_page.dart';
import 'package:enjoy_android/widget/main/system_page.dart';
import 'package:enjoy_android/widget/sub/home_drawer.dart';
import 'package:enjoy_android/global/common.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  PageController _pageController;

  List<BottomNavigationBarItem> _bottomTabs;

  @override
  void initState() {
    super.initState();
    _bottomTabs = <BottomNavigationBarItem>[
      _bnItem(Icons.home, '首页'),
      _bnItem(Icons.apps, '体系'),
      _bnItem(Icons.send, '导航'),
      _bnItem(Icons.directions, '项目'),
    ];
    _pageController = PageController(initialPage: this._page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    User().refreshUserData();
    return Scaffold(
      drawer: Drawer(child: HomeDrawer(context).homeDrawer(),),
      appBar: AppBar(
        title: Text('玩Android'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () { goTo(context, SearchPage()); }),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          SystemPage(),
          SearchPage(),
          ProjectPage(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabs,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
      ),
    );
  }

  _bnItem(IconData icon, String title){
    return BottomNavigationBarItem(
      icon: Icon(icon),
      title: Text(title),
    );
  }

  void onTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}