import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

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
