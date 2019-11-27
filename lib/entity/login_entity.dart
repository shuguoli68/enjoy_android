/**
 * https://www.wanandroid.com/user/login
		方法：POST
		参数：
		username，password
 * {
		"data": {
		"admin": false,
		"chapterTops": [],
		"collectIds": [],
		"email": "",
		"icon": "",
		"id": 36765,
		"nickname": "lihui",
		"password": "",
		"publicName": "lihui",
		"token": "",
		"type": 0,
		"username": "lihui"
		},
		"errorCode": 0,
		"errorMsg": ""
		}
 */

class LoginEntity {
	LoginData data;
	int errorCode;
	String errorMsg;

	LoginEntity({this.data, this.errorCode, this.errorMsg});

	LoginEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class LoginData {
	String password;
	String publicName;
	List<Null> chapterTops;
	String icon;
	String nickname;
	bool admin;
	List<Null> collectIds;
	int id;
	int type;
	String email;
	String token;
	String username;

	LoginData({this.password, this.publicName, this.chapterTops, this.icon, this.nickname, this.admin, this.collectIds, this.id, this.type, this.email, this.token, this.username});

	LoginData.fromJson(Map<String, dynamic> json) {
		password = json['password'];
		publicName = json['publicName'];
		if (json['chapterTops'] != null) {
			chapterTops = new List<Null>();
		}
		icon = json['icon'];
		nickname = json['nickname'];
		admin = json['admin'];
		if (json['collectIds'] != null) {
			collectIds = new List<Null>();
		}
		id = json['id'];
		type = json['type'];
		email = json['email'];
		token = json['token'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = this.password;
		data['publicName'] = this.publicName;
		if (this.chapterTops != null) {
      data['chapterTops'] =  [];
    }
		data['icon'] = this.icon;
		data['nickname'] = this.nickname;
		data['admin'] = this.admin;
		if (this.collectIds != null) {
      data['collectIds'] =  [];
    }
		data['id'] = this.id;
		data['type'] = this.type;
		data['email'] = this.email;
		data['token'] = this.token;
		data['username'] = this.username;
		return data;
	}
}
