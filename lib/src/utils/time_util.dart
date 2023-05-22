import 'package:common_utils_v2/common_utils_v2.dart';

class TimeUtil {
  /// 获取当前时间戳
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 获取时间戳
  /// timeStr 格式 yyyy-MM-dd hh:mm:ss
  static int currentTimeMillisWithTime(String timeStr) {
    return DateTime.parse(timeStr.toString()).millisecondsSinceEpoch;
  }

  /// 根据时间戳 计算截至现在的天数
  /// timeStr 格式 yyyy-MM-dd hh:mm:ss
  static String getDayBetweenNow(String timeStr) {
    if (TextUtils.isEmpty(timeStr)) {
      return "";
    }
    return DateTime.now().difference(DateTime.parse(timeStr)).inDays.toString();
  }



  /// 时间戳格式化  默认格式化格式 yyyy-MM-dd hh:mm:ss
  /// timeStamp 毫秒
  static String timeStampToStr(String timeStamp) {
    if (TextUtils.isEmpty(timeStamp.toString())) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch( int.parse(timeStamp));
    return _dateTimeToStr(dateTime);
  }


  /// 时间戳格式化(当前时间)  默认格式化格式 yyyy-MM-dd hh:mm:ss
  static String timeStampToStrNow() {
    return _dateTimeToStr(DateTime.now());
  }


  /// DateTime to String
  static String _dateTimeToStr(DateTime dateTime) {
    int year = dateTime.year; // 当前年
    int month = dateTime.month; // 当前月
    int day = dateTime.day; // 当前日
    int hour = dateTime.hour; // 当前时
    int minute = dateTime.minute; // 当前分
    int second = dateTime.second; // 当前秒
    int millisecond = dateTime.millisecond; // 当前毫秒
    int microsecond = dateTime.microsecond; // 当前微秒

    String monthStr = month < 10 ? ("0" + month.toString()) : month.toString();
    String dayStr = day < 10 ? ("0" + day.toString()) : day.toString();
    String hourStr = hour < 10 ? ("0" + hour.toString()) : hour.toString();
    String minuteStr = minute < 10 ? ("0" + minute.toString()) : minute.toString();
    String secondStr = second < 10 ? ("0" + second.toString()) : second.toString();
    return "$year-$monthStr-$dayStr $hourStr:$minuteStr:$secondStr";
  }
}
