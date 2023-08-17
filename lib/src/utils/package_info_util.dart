import 'package:common_utils_v2/common_utils_v2.dart';

class PackageInfoUtil {
  /// 获取当前应用程序信息
  static Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
