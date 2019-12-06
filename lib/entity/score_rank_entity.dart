class ScoreRankEntity {
    SRData data;
    int errorCode;
    String errorMsg;

    ScoreRankEntity({this.data, this.errorCode, this.errorMsg});

    factory ScoreRankEntity.fromJson(Map<String, dynamic> json) {
        return ScoreRankEntity(
            data: json['data'] != null ? SRData.fromJson(json['data']) : null, 
            errorCode: json['errorCode'], 
            errorMsg: json['errorMsg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCode'] = this.errorCode;
        data['errorMsg'] = this.errorMsg;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class SRData {
    int curPage;
    List<SRDataX> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    SRData({this.curPage, this.datas, this.offset, this.over, this.pageCount, this.size, this.total});

    factory SRData.fromJson(Map<String, dynamic> json) {
        return SRData(
            curPage: json['curPage'],
            datas: json['datas'] != null ? (json['datas'] as List).map((i) => SRDataX.fromJson(i)).toList() : null,
            offset: json['offset'],
            over: json['over'],
            pageCount: json['pageCount'],
            size: json['size'],
            total: json['total'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['curPage'] = this.curPage;
        data['offset'] = this.offset;
        data['over'] = this.over;
        data['pageCount'] = this.pageCount;
        data['size'] = this.size;
        data['total'] = this.total;
        if (this.datas != null) {
            data['datas'] = this.datas.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class SRDataX {
    int coinCount;
    int level;
    int rank;
    int userId;
    String username;

    SRDataX({this.coinCount, this.level, this.rank, this.userId, this.username});

    factory SRDataX.fromJson(Map<String, dynamic> json) {
        return SRDataX(
            coinCount: json['coinCount'],
            level: json['level'],
            rank: json['rank'],
            userId: json['userId'],
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['coinCount'] = this.coinCount;
        data['level'] = this.level;
        data['rank'] = this.rank;
        data['userId'] = this.userId;
        data['username'] = this.username;
        return data;
    }
}