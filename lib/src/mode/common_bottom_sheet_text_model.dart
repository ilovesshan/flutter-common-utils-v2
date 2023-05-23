/// 底部弹框 通用Mode(Text)
class CommonBottomSheetTextModel {
  CommonBottomSheetTextModel({
    required this.name,
    required this.id,
  });

  String name;
  String id;

  factory CommonBottomSheetTextModel.fromJson(Map<String, dynamic> json) => CommonBottomSheetTextModel(
    name: json["name"].toString(),
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
  @override
  bool operator ==(Object other) {
    return name! == (other as CommonBottomSheetTextModel).name;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    return result;
  }
}