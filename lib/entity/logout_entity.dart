class LogoutEntity {
    Object data;
    int errorCode;
    String errorMsg;

    LogoutEntity({this.data, this.errorCode, this.errorMsg});

    factory LogoutEntity.fromJson(Map<String, dynamic> json) {
        return LogoutEntity(
            data: json['data'] ,//!= null ? Object.fromJson(json['data']) : null,
            errorCode: json['errorCode'], 
            errorMsg: json['errorMsg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCode'] = this.errorCode;
        data['errorMsg'] = this.errorMsg;
        if (this.data != null) {
            data['data'] = null;//this.data.toJson();
        }
        return data;
    }
}