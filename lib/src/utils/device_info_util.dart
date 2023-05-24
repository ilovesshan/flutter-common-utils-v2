import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:common_utils_v2/common_utils_v2.dart';


enum RunTimePlatform { ANDRID, IOS, LINUX, MACOS, WINDOWS, WEBBROWSER, UNKNOW }

class DeviceInfoUtil {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  /// 获取运行环境
  Future<RunTimePlatform> getRunTimePlatform() async {
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

  /// 获取android设备信息
  Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    return await deviceInfoPlugin.androidInfo;
  }

  /// 获取ios设备信息
  Future<IosDeviceInfo> getIosDeviceInfo() async {
    return await deviceInfoPlugin.iosInfo;
  }

  /// 获取linux设备信息
  Future<LinuxDeviceInfo> getLinuxDeviceInfo() async {
    return await deviceInfoPlugin.linuxInfo;
  }

  /// 获取macOs设备信息
  Future<MacOsDeviceInfo> getMacOsDeviceInfo() async {
    return await deviceInfoPlugin.macOsInfo;
  }

  /// 获取windows设备信息
  Future<WindowsDeviceInfo> getWindowsDeviceInfo() async {
    return await deviceInfoPlugin.windowsInfo;
  }

  /// 获取webBrowser设备信息
  Future<WebBrowserInfo> getWebBrowserInfo() async {
    return await deviceInfoPlugin.webBrowserInfo;
  }
}
