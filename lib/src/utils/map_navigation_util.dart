import 'dart:io';

import 'package:common_utils_v2/common_utils_v2.dart';

class MapNavigationUtil {

  /// 百度地图
  static Future<bool> gotoBaiduMap(longitude, latitude) async {
    var url = 'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
     ToastUtil.show("未检测到百度地图");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 腾讯地图
  static Future<bool> gotoTencentMap(longitude, latitude) async {
    var url = 'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
     ToastUtil.show("未检测到腾讯地图");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 高德地图
  static Future<bool> gotoGaoDeMap(longitude, latitude) async {
    var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
     ToastUtil.show("未检测到高德地图");
      return false;
    }
    await launch(url);
    return true;
  }

  /// 依次检测调用  高德地图 -> 腾讯地图 -> 百度地图
  static Future<bool> gotoMap(longitude, latitude) async {
    var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';
    ///  尝试 高德地图
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      /// 尝试 腾讯地图
      url = 'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
      bool canLaunchUrl = await canLaunch(url);
      if (!canLaunchUrl) {
        /// 尝试 百度地图
        url = 'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';
        bool canLaunchUrl = await canLaunch(url);
        if (!canLaunchUrl) {
         ToastUtil.show("抱歉，未检测到您手机安装的导航类应用");
          return false;
        }
      }
    }
    await launch(url);
    return true;
  }
}
