import 'package:flutter/material.dart';


/// 底部弹框 通用Mode(Icon + Text)
class CommonBottomSheetIconModel {
  IconData icon;
  String name;
  String id;

  CommonBottomSheetIconModel({required this.icon, required this.name, required this.id,});
}


/// 底部弹框 通用Mode(Text)
class CommonBottomSheetTextModel {
  String name;
  String id;

  CommonBottomSheetTextModel({required this.name, required this.id,});
}

class CommonBottomSheetConstants {
  static List<CommonBottomSheetTextModel> pickerOptions = [
    CommonBottomSheetTextModel(name: "拍照上传", id: "0"),
    CommonBottomSheetTextModel(name: "相册选取", id: "1"),
    CommonBottomSheetTextModel(name: "取消", id: "2")
  ];

  static List<CommonBottomSheetIconModel> commonBottomSheetIconList = [
    CommonBottomSheetIconModel(icon: Icons.image, name: "图片", id: "1"),
    CommonBottomSheetIconModel(icon: Icons.camera_alt, name: "拍摄", id: "2"),
    CommonBottomSheetIconModel(icon: Icons.phone, name: "语音通话", id: "3"),
    CommonBottomSheetIconModel(icon: Icons.video_call, name: "视频通话", id: "4"),
    CommonBottomSheetIconModel(icon: Icons.monetization_on_sharp, name: "发红包", id: "5"),
    CommonBottomSheetIconModel(icon: Icons.thumbs_up_down_rounded, name: "戳一戳", id: "6"),
  ];
}
