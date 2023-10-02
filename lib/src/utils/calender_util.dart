import 'package:common_utils_v2/common_utils_v2.dart';

class CalendarUtil {
  /// 根据名称获取对于的CalendarId
  static Future<String> getCalendarId(String name) async {
    String calendarId = "";

    /// 申请获取日历相关权限
    var isGrantedCalendar = await PermissionUtil.requestCalendarPermission();
    if (isGrantedCalendar) {
      final deviceCalendarPlugin = DeviceCalendarPlugin();
      final permissionsGranted = await deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess) {
        final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
        if (calendarsResult.isSuccess) {
          final calendars = calendarsResult.data;
          for (var calendar in calendars!) {
            if (calendar.name == name) {
              calendarId = calendar.id ?? "";
            }
          }
        } else {
          Log.e('检索日历失败: ${calendarsResult.errors[0].errorMessage}');
        }
      }
    }
    return calendarId;
  }

  /// 根据ID删除日历
  static Future<bool> deleteCalendarById(String calenderId) async {
    bool deleteSuccess = false;

    /// 申请获取日历相关权限
    var isGrantedCalendar = await PermissionUtil.requestCalendarPermission();
    if (isGrantedCalendar) {
      final deviceCalendarPlugin = DeviceCalendarPlugin();
      var res = (await deviceCalendarPlugin.deleteCalendar(calenderId));
      deleteSuccess = res.data ?? false;
    }
    return deleteSuccess;
  }
}
