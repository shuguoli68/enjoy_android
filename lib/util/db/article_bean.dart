///
/// 本地存储数据：收藏文章
///
class ArticleBean {
	String upTime;
	String author;
	String link;
	int id;
	String title;

	ArticleBean({this.upTime, this.author, this.link, this.id, this.title});

	ArticleBean.fromJson(Map<String, dynamic> json) {
		upTime = json['upTime'];
		author = json['author'];
		link = json['link'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['upTime'] = this.upTime;
		data['author'] = this.author;
		data['link'] = this.link;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
