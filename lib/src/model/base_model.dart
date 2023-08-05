class BaseModel<T> {
  BaseModel({this.data, this.message, required this.code});

  T? data;
  String? message;
  num? code;

  BaseModel.fromJson(dynamic json) {
    message = json["message"];
    code = json["code"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}
