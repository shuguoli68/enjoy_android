class HotwordEntity {
    List<HotData> data;
    int errorCode;
    String errorMsg;

    HotwordEntity({this.data, this.errorCode, this.errorMsg});

    factory HotwordEntity.fromJson(Map<String, dynamic> json) {
        return HotwordEntity(
            data: json['data'] != null ? (json['data'] as List).map((i) => HotData.fromJson(i)).toList() : null,
            errorCode: json['errorCode'], 
            errorMsg: json['errorMsg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCode'] = this.errorCode;
        data['errorMsg'] = this.errorMsg;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class HotData {
    int id;
    String link;
    String name;
    int order;
    int visible;

    HotData({this.id, this.link, this.name, this.order, this.visible});

    factory HotData.fromJson(Map<String, dynamic> json) {
        return HotData(
            id: json['id'],
            link: json['link'],
            name: json['name'],
            order: json['order'],
            visible: json['visible'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['link'] = this.link;
        data['name'] = this.name;
        data['order'] = this.order;
        data['visible'] = this.visible;
        return data;
    }
}