import 'package:common_utils_v2/common_utils_v2.dart';

class NotificationUtil {
  static final FlutterLocalNotificationsPlugin _fnp = FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin get fnp => _fnp;


  /// 初始化通知插件
  static Future<void> initNotification({DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification, DidReceiveNotificationResponseCallback? onDidReceiveNotificationResponse}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  /// 发送本地通知(普通文本展示)
  static notifyMessage({
    required String title,
    String? body,
    int? notificationId,
    String? channelId,
    String? channelName,
    String? channelDescription,
    String? tag,
    String? payload,
    String? ticker,
  }) {
    /// android相关配置
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      /// 区分不同渠道的标识
      channelId ?? "channelId",

      /// 渠道的名称
      channelName ?? "channelName",

      /// 渠道的描述
      channelDescription: channelDescription,

      /// 通知的级别
      importance: Importance.max,

      /// 通知标记
      tag: tag,

      ticker: ticker,
    );

    /// ios相关配置
    DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(threadIdentifier: channelId);

    /// 推送通知
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iOSPlatformChannelSpecifics);
    fnp.show(notificationId ?? DateTime.now().millisecondsSinceEpoch >> 10, title, body, notificationDetails, payload: payload);
  }

  /// 发送本地通知(带进度条)
  static showLoadingNotify({
    required String title,
    required int progress,
    String? body,
    int? maxProgress,
    bool? indeterminate,
    int? notificationId,
    String? channelId,
    String? channelName,
    String? channelDescription,
    String? tag,
    String? payload,
    String? ticker,
  }) {
    /// android相关配置
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      /// 区分不同渠道的标识
      channelId ?? "channelId",

      /// 渠道的名称
      channelName ?? "channelName",

      /// 渠道的秒速
      channelDescription: channelDescription,

      /// 通知的级别
      importance: Importance.unspecified,
      priority: Priority.low,

      /// 通知标记
      tag: tag,

      ticker: ticker,

      /// 显示进度条
      showProgress: true,

      /// 当前进度值
      progress: progress,

      /// 最大进度值
      maxProgress: maxProgress ?? 100,

      /// 是否显示不确定进度条。
      indeterminate: indeterminate ?? false,

      /// Android任务栏下的清除按钮是否不能够清除该通知
      ongoing: true,

      /// 相同ID的通知, 是否仅第一次时播放声音或者振动
      onlyAlertOnce: true,

      /// 是否在点击时自动关闭通知
      autoCancel: false,
    );

    /// ios相关配置
    DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(threadIdentifier: channelId);

    /// 推送通知
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iOSPlatformChannelSpecifics);
    fnp.show(notificationId ?? DateTime.now().millisecondsSinceEpoch >> 10, title, body, notificationDetails, payload: payload);
  }

  ///清除所有通知
  static Future<void> cleanNotification() async {
    await fnp.cancelAll();
  }

  ///清除指定id的通知
  /// `tag`参数指定Android标签(如果提供). 那么同时匹配 id 和 tag 的通知将会被取消, `tag` 对其他平台没有影响。
  static Future<void> cancelNotification(int id, {String? tag}) async {
    await fnp.cancel(id, tag: tag);
  }

  /// 获取有关是否使用了从此插件创建的通知来启动应用程序的信息。
  static Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() {
    return fnp.getNotificationAppLaunchDetails();
  }
}
