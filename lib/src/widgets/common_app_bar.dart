import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

class CommonAppBar {
  /// 简朴白
  static AppBar show(String text, {Widget? leading, List<Widget>? actions, PreferredSizeWidget? bottom, double? elevation}) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      title: Text(text, style: TextStyle(fontSize: 18.sp, color: const Color(0xFF222222))),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: elevation ?? 0,
      leading: leading ?? IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22), onPressed: () => Get.back()),
      actions: actions,
      bottom: bottom,
    );
  }

  /// 主题色
  static AppBar showWidthPrimaryTheme(String text, {Widget? leading, List<Widget>? actions, PreferredSizeWidget? bottom, double? elevation}) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      title: Text(text, style: TextStyle(fontSize: 18.sp, color: const Color(0xFFFFFFFF))),
      backgroundColor: Get.theme.primaryColor,
      centerTitle: true,
      elevation: elevation ?? 0,
      leading: leading ?? IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22), onPressed: () => Get.back()),
      actions: actions,
      bottom: bottom,
    );
  }
}
