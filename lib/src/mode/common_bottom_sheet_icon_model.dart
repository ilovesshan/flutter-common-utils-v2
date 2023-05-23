import 'package:flutter/material.dart';

/// 底部弹框 通用Mode(Icon + Text)
class CommonBottomSheetIconModel {
  CommonBottomSheetIconModel({
    required this.icon,
    required this.name,
    required this.id,
  });

  IconData icon;
  String name;
  String id;

  factory CommonBottomSheetIconModel.fromJson(Map<String, dynamic> json) => CommonBottomSheetIconModel(
    icon: json["icon"],
    name: json["name"].toString(),
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "name": name,
    "id": id,
  };
  @override
  bool operator ==(Object other) {
    return name== (other as CommonBottomSheetIconModel).name;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    return result;
  }
}