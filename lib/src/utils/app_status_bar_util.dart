import 'package:common_utils_v2/common_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStatusBarUtil {
  ///设置状态栏主题
  static void setStatusBarTheme(bool isLight) {
    SystemUiOverlayStyle systemUiOverlayStyle;
    if (isLight) {
      systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light);
    } else {
      systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    }
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  ///显示状态栏
  static showStatusBar() {
    if (DeviceInfoUtil.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    }
  }

  ///隐藏状态栏
  static hideStatusBar() {
    if (DeviceInfoUtil.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }
}
