import 'package:common_utils_v2/common_utils_v2.dart';


class SpUtil {
  static late SharedPreferences _sharedPreferences;

  static SharedPreferences get sharedPreferences => _sharedPreferences;

  ///初始化工具
  static Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// 根据Key获取值
  static String getValue(String key, {String defaultValue = ""}) {
    return SpUtil.sharedPreferences.getString(key) ?? defaultValue;
  }

  /// 根据key设置值
  static Future<bool> setValue(String key, String value) async {
    return await SpUtil.sharedPreferences.setString(key, value);
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
}
