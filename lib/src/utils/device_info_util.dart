import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

enum RunTimePlatform { ANDRID, IOS, LINUX, MACOS, WINDOWS, WEBBROWSER, UNKNOW }

class DeviceInfoUtil {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  /// 获取运行环境
  static Future<RunTimePlatform> getRunTimePlatform() async {
    try {
      if (kIsWeb) {
        return RunTimePlatform.WEBBROWSER;
      } else {
        if (Platform.isAndroid) {
          return RunTimePlatform.ANDRID;
        } else if (Platform.isIOS) {
          return RunTimePlatform.IOS;
        } else if (Platform.isLinux) {
          return RunTimePlatform.LINUX;
        } else if (Platform.isMacOS) {
          return RunTimePlatform.MACOS;
        } else if (Platform.isWindows) {
          return RunTimePlatform.WINDOWS;
        } else {
          return RunTimePlatform.UNKNOW;
        }
      }
    } on PlatformException {
      Log.e("Failed to get platform version");
      return RunTimePlatform.UNKNOW;
    }
  }

  ///获取当前设备platform
  static TargetPlatform platform() {
    return Theme.of(Get.context!).platform;
  }

  ///是否是web端
  static bool get isWeb {
    return kIsWeb;
  }

  ///是否是安卓端
  static bool get isAndroid {
    if (kIsWeb) {
      return false;
    }
    return Platform.isAndroid;
  }

  ///是否是IOS端
  static bool get isIOS {
    if (kIsWeb) {
      return false;
    }
    return Platform.isIOS;
  }

  /// 获取android设备信息
  static Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    return await deviceInfoPlugin.androidInfo;
  }

  /// 获取ios设备信息
  static Future<IosDeviceInfo> getIosDeviceInfo() async {
    return await deviceInfoPlugin.iosInfo;
  }

  /// 获取linux设备信息
  static Future<LinuxDeviceInfo> getLinuxDeviceInfo() async {
    return await deviceInfoPlugin.linuxInfo;
  }

  /// 获取macOs设备信息
  static Future<MacOsDeviceInfo> getMacOsDeviceInfo() async {
    return await deviceInfoPlugin.macOsInfo;
  }

  /// 获取windows设备信息
  static Future<WindowsDeviceInfo> getWindowsDeviceInfo() async {
    return await deviceInfoPlugin.windowsInfo;
  }

  /// 获取webBrowser设备信息
  static Future<WebBrowserInfo> getWebBrowserInfo() async {
    return await deviceInfoPlugin.webBrowserInfo;
  }
}
