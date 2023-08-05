import 'dart:async';

import 'package:common_utils_v2/common_utils_v2.dart';
import 'package:geolocator/geolocator.dart';

typedef OnPositionStream = void Function(Position?);

class LocationUtil {
  /// 高德地图的baseUrl
  static const String gaoDeMapBaseUrl = "https://restapi.amap.com/v3";

  /// 逆地理编码API服务地址
  static const String getAddressLatLngPath = "$gaoDeMapBaseUrl/geocode/regeo";

  /// 地理编码API服务地址
  static const String geoPath = "$gaoDeMapBaseUrl/geocode/geo";

  /// 关键字搜索服务地址
  static const String getPlaceByTextPath = "$gaoDeMapBaseUrl/place/text";

  /// 周边搜索服务地址
  static const String getAroundPlaceByTextPath = "$gaoDeMapBaseUrl/place/around";

  /// 获取当前经纬度
  static Future<Position> getCurrentLatLng() async {
    await _checkGeolocatorPermission();
    return await Geolocator.getCurrentPosition();
  }

  /// 获取上一次已知的位置（如果没有位置详细可用，该方法会返回 null ）
  static Future<Position?> getLastKnownPosition() async {
    await _checkGeolocatorPermission();
    return await Geolocator.getLastKnownPosition();
  }

  /// 获取当前实时位置（监听位置变化）
  static void getPositionStream(OnPositionStream onPositionStream, {LocationSettings? locationSettings}) async {
    await _checkGeolocatorPermission();
    Geolocator.getPositionStream(locationSettings: locationSettings ?? const LocationSettings()).listen((Position position) => onPositionStream(position));
  }

  /// 计算两个地理坐标之间的距离(单位：米)
  static double distanceBetween({required Position startPosition, required Position endPosition}) {
    return Geolocator.distanceBetween(startPosition.latitude, startPosition.longitude, endPosition.latitude, endPosition.longitude);
  }

  /// 计算两个地理坐标之间的方位
  /// 相关方位参考地址： https://www.movable-type.co.uk/scripts/latlong.html#bearing.
  static double bearingBetween({required Position startPosition, required Position endPosition}) {
    return Geolocator.bearingBetween(startPosition.latitude, startPosition.longitude, endPosition.latitude, endPosition.longitude);
  }

  /// 根据经纬度获取当前地址信息
  /// 参考地址：https://lbs.amap.com/api/webservice/guide/api/georegeo#regeo
  static Future<dynamic> getAddressByLatLng({required double latitude, required longitude, required String webKey}) async {
    final requestPath = "$getAddressLatLngPath?key=$webKey&output=json&location=$longitude,$latitude&radius=1000&extensions=all";
    try {
      final BaseModel baseModel = await HttpHelperUtil.instance.get(requestPath);
      if (baseModel.data != null && TextUtil.isNotEmpty(baseModel.data["regeocode"].toString()) && baseModel.data["status"].toString() == "1") {
        return baseModel.data["regeocode"];
      } else {
        Log.e(baseModel.toJson());
      }
    } catch (e) {
      Log.e(e);
    }
  }

  /// 根据位置信息获取经纬度
  /// 参考地址：https://lbs.amap.com/api/webservice/guide/api/georegeo
  static Future<dynamic> getLatLngByAddress({required String address, required String webKey, String? city}) async {
    final requestPath = "$geoPath?key=$webKey&address=$address&output=json";
    try {
      final BaseModel baseModel = await HttpHelperUtil.instance.get(requestPath);
      if (baseModel.data != null && TextUtil.isNotEmpty(baseModel.data["regeocode"].toString()) && baseModel.data["status"].toString() == "1") {
        return baseModel.data["regeocode"];
      } else {
        Log.e(baseModel.toJson());
      }
    } catch (e) {
      Log.e(e);
    }
  }

  /// 关键字搜索
  /// 参考地址：https://developer.amap.com/api/webservice/guide/api/search#text
  static Future<dynamic> getPlaceByText({required String keywords, required String webKey, String? city, int offset = 20, int page = 1}) async {
    final requestPath = "$getPlaceByTextPath?key=$webKey&keywords=$keywords&city=$city&output=json&offset=$offset&page=$page&extensions=all";
    try {
      final BaseModel baseModel = await HttpHelperUtil.instance.get(requestPath);
      if (baseModel.data != null && TextUtil.isNotEmpty(baseModel.data["regeocode"].toString()) && baseModel.data["status"].toString() == "1") {
        return baseModel.data["regeocode"];
      } else {
        Log.e(baseModel.toJson());
      }
    } catch (e) {
      Log.e(e);
    }
  }

  /// 周边搜索
  /// 参考地址：https://developer.amap.com/api/webservice/guide/api/search#around
  static Future<dynamic> getAroundPlaceByText({required String location, required String webKey, String? city, int radius = 10000}) async {
    final requestPath = "$getAroundPlaceByTextPath?key=$webKey&location=$location&&radius=$radius";
    try {
      final BaseModel baseModel = await HttpHelperUtil.instance.get(requestPath);
      if (baseModel.data != null && TextUtil.isNotEmpty(baseModel.data["pois"].toString()) && baseModel.data["status"].toString() == "1") {
        return baseModel.data["pois"];
      } else {
        Log.e(baseModel.toJson());
      }
    } catch (e) {
      Log.e(e);
    }
  }

  /// 检查位置服务和位置信息权限授权情况
  static Future<void> _checkGeolocatorPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ToastUtil.showToast("当前设备位置服务不可用");
      Log.d("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ToastUtil.showToast("定位服务权限已被禁用,即将跳转设置中心");
        Future.delayed(const Duration(seconds: 1), () async {
          await Geolocator.openAppSettings();
        });
        Log.d("Location permissions are denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ToastUtil.showToast("定位服务权限已被禁用,即将跳转设置中心");
      Future.delayed(const Duration(seconds: 1), () async {
        await Geolocator.openAppSettings();
      });
      Log.d("Location permissions are permanently denied, we cannot request permissions.");
    }
  }
}
