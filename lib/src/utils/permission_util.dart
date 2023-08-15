import 'package:common_utils_v2/common_utils_v2.dart';

/// App权限工具类
class PermissionUtil {
  /// 获取全部权限
  static Future<void> requestAllPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.camera,
      Permission.photos,
      Permission.speech,
      Permission.storage,
      Permission.location,
      Permission.phone,
      Permission.microphone,
      Permission.notification,
      Permission.microphone,
    ].request();

    if (await Permission.camera.isGranted) {
      Log.d(StackTrace.current, "相机权限申请通过");
    } else {
      Log.d(StackTrace.current, "相机权限申请失败");
    }

    if (await Permission.photos.isGranted) {
      Log.d(StackTrace.current, "照片权限申请通过");
    } else {
      Log.d(StackTrace.current, "照片权限申请失败");
    }

    if (await Permission.speech.isGranted) {
      Log.d(StackTrace.current, "语音权限申请通过");
    } else {
      Log.d(StackTrace.current, "语音权限申请失败");
    }

    if (await Permission.microphone.isGranted) {
      Log.d(StackTrace.current, "麦克风权限申请通过");
    } else {
      Log.d(StackTrace.current, "麦克风权限申请失败");
    }

    if (await Permission.storage.isGranted) {
      Log.d(StackTrace.current, "文件权限申请通过");
    } else {
      Log.d(StackTrace.current, "文件权限申请失败");
    }

    if (await Permission.location.isGranted) {
      Log.d(StackTrace.current, "定位权限申请通过");
    } else {
      Log.d(StackTrace.current, "定位权限申请失败");
    }

    if (await Permission.phone.isGranted) {
      Log.d(StackTrace.current, "手机权限申请通过");
    } else {
      Log.d(StackTrace.current, "手机权限申请失败");
    }

    if (await Permission.notification.isGranted) {
      Log.d(StackTrace.current, "通知权限申请通过");
    } else {
      Log.d(StackTrace.current, "通知权限申请失败");
    }
  }

  /// 申请权限
  static Future<bool> requestPermission({required List<Permission> permissions, required List<String> permissionsDescribes}) async {
    bool isGranted = true;
    await permissions.request();
    for (var i = 0; i < permissions.length; i++) {
      /// 第一次申请被拒绝 (true)
      bool isDenied = await (permissions[i]).isDenied;

      /// 第二次申请被拒绝 (true)
      bool isPermanentlyDenied = await (permissions[i]).isPermanentlyDenied;

      /// 已授权 (true)
      bool isGranted = await (permissions[i]).isGranted;

      if (isGranted) {
        Log.d(StackTrace.current, "${permissions[i]}权限已授权");
      } else if (isDenied || isPermanentlyDenied) {
        isGranted = false;
        ToastUtil.showToast("为保证功能正常使用，请在设置中为app开启${permissions[i]}权限");
      }
    }
    return isGranted;
  }

  /// 相机权限
  static Future<bool> requestCameraPermission() async {
    return await requestPermission(permissions: [Permission.camera], permissionsDescribes: ["相机"]);
  }

  /// 照片/存储权限
  static Future<bool> requestPhotosPermission() async {
    return await requestPermission(permissions: [Permission.photos], permissionsDescribes: ["照片/存储"]);
  }

  ///  麦克风
  static Future<bool> requestMicrophonePermission() async {
    return await requestPermission(permissions: [Permission.microphone], permissionsDescribes: ["麦克风"]);
  }

  /// 语音
  static Future<bool> requestSpeechPermission() async {
    return await requestPermission(permissions: [Permission.speech], permissionsDescribes: ["语音"]);
  }

  /// 存储/文件权限
  static Future<bool> requestStoragePermission() async {
    return await requestPermission(permissions: [Permission.storage], permissionsDescribes: ["文件/存储"]);
  }

  /// 定位/位置信息权限
  static Future<bool> requestLocationPermission() async {
    return await requestPermission(permissions: [Permission.location], permissionsDescribes: ["定位/位置信息"]);
  }

  /// 手机系统权限
  static Future<bool> requestPhonePermission() async {
    return await requestPermission(permissions: [Permission.phone], permissionsDescribes: ["手机系统"]);
  }

  /// 通知权限
  static Future<bool> requestNotificationPermission() async {
    return await requestPermission(permissions: [Permission.notification], permissionsDescribes: ["通知"]);
  }

  ///IOS用的跟踪透明度权限申请
  static Future appTrackingTransparency() async {
    requestPermission(permissions: [Permission.appTrackingTransparency], permissionsDescribes: ["跟踪透明度"]);
  }
}
