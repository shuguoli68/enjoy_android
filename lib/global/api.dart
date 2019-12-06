class Api {

  ///
  ///ip
  ///来源：玩Android，https://wanandroid.com/blog/show/2
  ///
  static const String baseUrl = 'https://www.wanandroid.com';

  ///
  ///登录:/user/login
  ///方法：POST，参数：username，password
  ///
  static const String login = '/user/login';

  ///
  ///注册:/user/register
  ///方法：POST，参数：username，password, repassword
  ///
  static const String register = '/user/register';

  ///
  ///退出:https://www.wanandroid.com/user/logout/json
  ///方法：GET, 参数：无
  ///
  static const String logout = '/user/logout/json';

  ///
  ///首页banner:/banner/json
  ///方法：GET, 参数：无
  ///
  static const String banner = '/banner/json';

  ///
  ///首页文章列表:/article/list/0/json
  ///方法：GET, 参数：页码，拼接在连接中，从0开始。
  ///
  static const String article = '/article/list/';

  ///
  ///体系数据:/tree/json
  ///方法：GET, 参数：无
  ///
  static const String systemTree = '/tree/json';

  ///
  ///体系数据:/article/list/0/json?cid=60
  ///方法：GET, 参数：cid 分类的id，上述二级目录的id; 页码：拼接在链接上，从0开始。
  ///
  static const String systemSub = '/article/list/';

  ///
  ///导航数据:https://www.wanandroid.com/navi/json
  ///方法：GET, 参数：无。
  ///
  static const String navigate = '/navi/json';

  ///
  ///项目分类:https://www.wanandroid.com/project/tree/json
  ///方法：GET, 参数：无。
  ///
  static const String projectTree = '/project/tree/json';

  ///
  ///项目列表:https://www.wanandroid.com/project/list/1/json?cid=294
  ///方法：GET, 参数：cid 分类的id，上面项目分类接口; 页码：拼接在链接中，从1开始。
  ///
  static const String projectSub = '/project/list/';


  ///
  ///搜索热词: https://www.wanandroid.com/hotkey/json
  ///方法：GET, 参数：无
  ///
  static const String hotword = '/hotkey/json';

  ///
  ///搜索: https://www.wanandroid.com/article/query/0/json
  ///方法：POST, 参数：k ： 搜索关键词; 页码：拼接在链接上，从0开始。
  ///
  static const String search = '/article/query/';

  ///
  ///积分排行榜: https://www.wanandroid.com/coin/rank/1/json
  ///方法：GET, 参数：分页page
  ///
  static const String scoreRank = '/coin/rank/';

  ///
  ///个人积分: https://www.wanandroid.com/lg/coin/userinfo/json
  ///
  static const String myScore = '/lg/coin/userinfo/json';

  ///
  ///收藏文章: https://www.wanandroid.com/lg/collect/1165/json
  ///
  static const String collect = '/lg/collect/';

  ///
  ///取消收藏文章: https://www.wanandroid.com/lg/uncollect_originId/2333/json
  ///
  static const String uncollect = '/lg/uncollect_originId/';

  ///
  ///收藏文章列表: https://www.wanandroid.com/lg/collect/list/0/json
  ///
  static const String collectList = '/lg/collect/list/';
}