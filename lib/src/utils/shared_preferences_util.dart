import 'package:common_utils_v2/common_utils_v2.dart';

class SpUtil {
  static late SharedPreferences _sharedPreferences;

  static SharedPreferences get sharedPreferences => _sharedPreferences;

  ///初始化工具
  static Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// 根据key删除值
  static Future<bool> removeValue(String key) async {
    return await SpUtil.sharedPreferences.remove(key);
  }

  /// 清除所有持久化数据
  static Future<bool> clean(String key) async {
    return await SpUtil.sharedPreferences.clear();
  }

  /// 是否包含key
  static containsKey(String key) async {
    return SpUtil.sharedPreferences.containsKey(key);
  }

  /// 重新加载所有数据（仅重载运行时）
  static Future<void> reload(String key) async {
    return await SpUtil.sharedPreferences.reload();
  }

  /// 根据key设置值(String)
  static Future<bool> setString(String key, String value) async {
    return await SpUtil.sharedPreferences.setString(key, value);
  }

  /// 根据Key获取值 (String)
  static String getString(String key, {String defaultValue = ""}) {
    return SpUtil.sharedPreferences.getString(key) ?? defaultValue;
  }

  /// 根据key设置值 (bool)
  static Future<bool> setBool(String key, bool value) async {
    return await SpUtil.sharedPreferences.setBool(key, value);
  }

  /// 根据Key获取值 (bool)
  static bool getBool(String key, {bool defaultValue = false}) {
    return SpUtil.sharedPreferences.getBool(key) ?? defaultValue;
  }

  /// 根据key设置值 (int)
  static Future<bool> setInt(String key, int value) async {
    return await SpUtil.sharedPreferences.setInt(key, value);
  }

  /// 根据Key获取值 (int)
  static int getInt(String key, {int defaultValue = 0}) {
    return SpUtil.sharedPreferences.getInt(key) ?? defaultValue;
  }

  /// 根据key设置值(setDouble)
  static Future<bool> setDouble(String key, double value) async {
    return await SpUtil.sharedPreferences.setDouble(key, value);
  }

  /// 根据Key获取值 (setDouble)
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return SpUtil.sharedPreferences.getDouble(key) ?? defaultValue;
  }

  /// 根据key设置值 (List<String>)
  static Future<bool> setStringList(String key, List<String> value) async {
    return await SpUtil.sharedPreferences.setStringList(key, value);
  }

  /// 根据Key获取值 (List<String>)
  static List<String> getStringList(String key, {List<String> defaultValue = const []}) {
    return SpUtil.sharedPreferences.getStringList(key) ?? defaultValue;
  }
}
