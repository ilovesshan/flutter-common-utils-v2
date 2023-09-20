import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

class CommonAppBar {
  static AppBar show(String text,
      {Widget? leading, List<Widget>? actions, PreferredSizeWidget? bottom, double? elevation, Color? color, Color? backgroundColor, Color? leadingColor, bool? centerTitle, Brightness? statusBarIconBrightness}) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light),
      title: Text(text, style: TextStyle(fontSize: 18.sp, color: color ?? const Color(0xFFFFFFFF))),
      backgroundColor: backgroundColor ?? Get.theme.primaryColor,
      centerTitle: centerTitle ?? true,
      elevation: elevation ?? 0,
      leading: leading ?? IconButton(icon: Icon(Icons.arrow_back_ios, color: leadingColor ?? Colors.black, size: 22), onPressed: () => Get.back()),
      actions: actions,
      bottom: bottom,
    );
  }
}
