class Api {

  /**
   * ip
   * 来源：玩Android，https://wanandroid.com/blog/show/2
   */
  static const String baseUrl = 'https://www.wanandroid.com';

  /**
   * 登录:/user/login
   * 方法：POST，参数：username，password
   */
  static const String login = '/user/login';

  /**
   * 注册:/user/register
   * 方法：POST，参数：username，password, repassword
   */
  static const String register = '/user/register';

  /**
   * 首页banner:/banner/json
   * 方法：GET, 参数：无
   */
  static const String banner = '/banner/json';

  /**
   * 首页文章列表:/article/list/0/json
   * 方法：GET, 参数：页码，拼接在连接中，从0开始。
   */
  static const String article = '/article/list/';

  /**
   * 体系数据:/tree/json
   * 方法：GET, 参数：无
   */
  static const String systemTree = '/tree/json';
}