import 'package:common_utils_v2/common_utils_v2.dart';

class ConnectivityUtil {
  static Connectivity connectivity = Connectivity();

  /// 判断是否接入网络
  static Future<bool> isConnect() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
