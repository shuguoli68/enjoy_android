class ProjectTabEntity {
    List<ProData> mData;
    int errorCode;
    String errorMsg;

    ProjectTabEntity({this.mData, this.errorCode, this.errorMsg});

    factory ProjectTabEntity.fromJson(Map<String, dynamic> json) {
        return ProjectTabEntity(
            mData: json['data'] != null ? (json['data'] as List).map((i) => ProData.fromJson(i)).toList() : null,
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

class ProData {
    List<Object> children;
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    ProData({this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

    factory ProData.fromJson(Map<String, dynamic> json) {
        return ProData(
            children: json['children'] ,//!= null ? (json['children'] as List).map((i) => Object.fromJson(i)).toList() : null,
            courseId: json['courseId'],
            id: json['id'],
            name: json['name'],
            order: json['order'],
            parentChapterId: json['parentChapterId'],
            userControlSetTop: json['userControlSetTop'],
            visible: json['visible'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['courseId'] = this.courseId;
        data['id'] = this.id;
        data['name'] = this.name;
        data['order'] = this.order;
        data['parentChapterId'] = this.parentChapterId;
        data['userControlSetTop'] = this.userControlSetTop;
        data['visible'] = this.visible;
        if (this.children != null) {
            data['children'] = null;//this.children.map((v) => v.toJson()).toList();
        }
        return data;
    }
}