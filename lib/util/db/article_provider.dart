
import 'package:enjoy_android/util/db/article_bean.dart';
import 'package:enjoy_android/util/db/base_db_provider.dart';
import 'package:sqflite/sqflite.dart';

class ArticleProvider extends BaseDbProvider{
  ///表名
  final String name = 'ArticleInfo';

  final String columnId = 'id';
  final String title = 'title';
  final String upTime = 'upTime';
  final String author = 'author';
  final String link = 'link';


  ArticleProvider();

  @override
  tableName() {
    return name;
  }

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key,$title text not null,$upTime text not null,$author text not null,$link text not null)
      ''';
  }

  ///查询数据库
  Future _getArticleProvider(Database db, int id) async {
    List<Map<String, dynamic>> maps =
    await db.rawQuery("select * from $name where $columnId = $id");
    return maps;
  }

  ///插入到数据库
  Future insert(ArticleBean model) async {
    Database db = await getDataBase();
    var userProvider = await _getArticleProvider(db, model.id);
    if (userProvider != null) {
      ///删除数据
      await db.delete(name, where: "$columnId = ?", whereArgs: [model.id]);
    }
    return await db.rawInsert("insert into $name ($columnId,$title,$upTime,$author,$link) values (?,?,?,?,?)",[model.id,model.title,model.upTime,model.author,model.link]);
  }

  ///从数据库删除
  Future delete(int id) async {
    Database db = await getDataBase();
    var userProvider = await _getArticleProvider(db, id);
    if (userProvider != null) {
      ///删除数据
      return await db.delete(name, where: "$columnId = ?", whereArgs: [id]);
    }
  }

  ///更新数据库
  Future<void> update(ArticleBean model) async {
    Database database = await getDataBase();
    await database.rawUpdate(
        "update $name set $title = ?,$upTime = ?,$author = ?,$link = ? where $columnId= ?",[model.title,model.upTime,model.author,model.link,model.id]);

  }

  ///获取存储的列表
  Future<List<ArticleBean>> getArticleList() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from $name");
    List<ArticleBean> list = new List();
    for(Map<String, dynamic> item in maps){
      list.add(ArticleBean.fromJson(item));
    }
    return list;
  }


  ///获取事件数据
  Future<ArticleBean> getArticleInfo(int id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps  = await _getArticleProvider(db, id);
    if (maps.length > 0) {
      return ArticleBean.fromJson(maps[0]);
    }
    return null;
  }

}