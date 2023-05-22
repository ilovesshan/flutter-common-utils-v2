/// 底部弹框 通用Mode
class CommonBottomSheetResultModel {
  CommonBottomSheetResultModel({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory CommonBottomSheetResultModel.fromJson(Map<String, dynamic> json) => CommonBottomSheetResultModel(
    name: json["name"].toString(),
    value: json["value"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
  @override
  bool operator ==(Object other) {
    return name! == (other as CommonBottomSheetResultModel).name;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    return result;
  }
}