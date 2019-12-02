class NavigateEntity {
    List<NaviData> mData;
    int errorCode;
    String errorMsg;

    NavigateEntity({this.mData, this.errorCode, this.errorMsg});

    factory NavigateEntity.fromJson(Map<String, dynamic> json) {
        return NavigateEntity(
            mData: json['data'] != null ? (json['data'] as List).map((i) => NaviData.fromJson(i)).toList() : null,
            errorCode: json['errorCode'], 
            errorMsg: json['errorMsg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCode'] = this.errorCode;
        data['errorMsg'] = this.errorMsg;
        if (this.mData != null) {
            data['data'] = this.mData.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class NaviData {
    List<Article> articles;
    int cid;
    String name;

    NaviData({this.articles, this.cid, this.name});

    factory NaviData.fromJson(Map<String, dynamic> json) {
        return NaviData(
            articles: json['articles'] != null ? (json['articles'] as List).map((i) => Article.fromJson(i)).toList() : null,
            cid: json['cid'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cid'] = this.cid;
        data['name'] = this.name;
        if (this.articles != null) {
            data['articles'] = this.articles.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Article {
    String apkLink;
    int audit;
    String author;
    int chapterId;
    String chapterName;
    bool collect;
    int courseId;
    String desc;
    String envelopePic;
    bool fresh;
    int id;
    String link;
    String niceDate;
    String niceShareDate;
    String origin;
    String prefix;
    String projectLink;
    int publishTime;
    int selfVisible;
    int shareDate;
    String shareUser;
    int superChapterId;
    String superChapterName;
    List<Object> tags;
    String title;
    int type;
    int userId;
    int visible;
    int zan;

    Article({this.apkLink, this.audit, this.author, this.chapterId, this.chapterName, this.collect, this.courseId, this.desc, this.envelopePic, this.fresh, this.id, this.link, this.niceDate, this.niceShareDate, this.origin, this.prefix, this.projectLink, this.publishTime, this.selfVisible, this.shareDate, this.shareUser, this.superChapterId, this.superChapterName, this.tags, this.title, this.type, this.userId, this.visible, this.zan});

    factory Article.fromJson(Map<String, dynamic> json) {
        return Article(
            apkLink: json['apkLink'],
            audit: json['audit'],
            author: json['author'],
            chapterId: json['chapterId'],
            chapterName: json['chapterName'],
            collect: json['collect'],
            courseId: json['courseId'],
            desc: json['desc'],
            envelopePic: json['envelopePic'],
            fresh: json['fresh'],
            id: json['id'],
            link: json['link'],
            niceDate: json['niceDate'],
            niceShareDate: json['niceShareDate'],
            origin: json['origin'],
            prefix: json['prefix'],
            projectLink: json['projectLink'],
            publishTime: json['publishTime'],
            selfVisible: json['selfVisible'],
            shareDate: json['shareDate'] != null ? json['shareDate'] : null,
            shareUser: json['shareUser'],
            superChapterId: json['superChapterId'],
            superChapterName: json['superChapterName'],
            tags: json['tags'] != null ? null : null,
            title: json['title'],
            type: json['type'],
            userId: json['userId'],
            visible: json['visible'],
            zan: json['zan'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['apkLink'] = this.apkLink;
        data['audit'] = this.audit;
        data['author'] = this.author;
        data['chapterId'] = this.chapterId;
        data['chapterName'] = this.chapterName;
        data['collect'] = this.collect;
        data['courseId'] = this.courseId;
        data['desc'] = this.desc;
        data['envelopePic'] = this.envelopePic;
        data['fresh'] = this.fresh;
        data['id'] = this.id;
        data['link'] = this.link;
        data['niceDate'] = this.niceDate;
        data['niceShareDate'] = this.niceShareDate;
        data['origin'] = this.origin;
        data['prefix'] = this.prefix;
        data['projectLink'] = this.projectLink;
        data['publishTime'] = this.publishTime;
        data['selfVisible'] = this.selfVisible;
        data['shareUser'] = this.shareUser;
        data['superChapterId'] = this.superChapterId;
        data['superChapterName'] = this.superChapterName;
        data['title'] = this.title;
        data['type'] = this.type;
        data['userId'] = this.userId;
        data['visible'] = this.visible;
        data['zan'] = this.zan;
        if (this.shareDate != null) {
            data['shareDate'] = this.shareDate;
        }
        if (this.tags != null) {
            data['tags'] = null;
        }
        return data;
    }
}