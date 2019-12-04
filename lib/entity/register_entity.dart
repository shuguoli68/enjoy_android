class RegisterEntity {
    RData data;
    int errorCode;
    String errorMsg;

    RegisterEntity({this.data, this.errorCode, this.errorMsg});

    factory RegisterEntity.fromJson(Map<String, dynamic> json) {
        return RegisterEntity(
            data: json['data'] != null ? RData.fromJson(json['data']) : null,
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


class RData {
    bool admin;
    List<String> chapterTops;
    List<int> collectIds;
    String email;
    String icon;
    int id;
    String nickname;
    String password;
    String publicName;
    String token;
    int type;
    String username;

    RData({this.admin, this.chapterTops, this.collectIds, this.email, this.icon, this.id, this.nickname, this.password, this.publicName, this.token, this.type, this.username});

    factory RData.fromJson(Map<String, dynamic> json) {
        return RData(
            admin: json['admin'],
            chapterTops: json['chapterTops'] != null ? new List<String>.from(json['chapterTops']) : null,
            collectIds: json['collectIds'] != null ? new List<int>.from(json['collectIds']) : null,
            email: json['email'],
            icon: json['icon'],
            id: json['id'],
            nickname: json['nickname'],
            password: json['password'],
            publicName: json['publicName'],
            token: json['token'],
            type: json['type'],
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['admin'] = this.admin;
        data['email'] = this.email;
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['nickname'] = this.nickname;
        data['password'] = this.password;
        data['publicName'] = this.publicName;
        data['token'] = this.token;
        data['type'] = this.type;
        data['username'] = this.username;
        if (this.chapterTops != null) {
            data['chapterTops'] = this.chapterTops;
        }
        if (this.collectIds != null) {
            data['collectIds'] = this.collectIds;
        }
        return data;
    }
}