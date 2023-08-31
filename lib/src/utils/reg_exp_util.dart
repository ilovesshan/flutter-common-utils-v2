import 'package:flutter/services.dart';

class RegExpConstants {
  /// 手机号(严谨) 正则
  static RegExp mobilePhoneExp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  /// 中文 正则
  static RegExp chineseExp = RegExp(r"[\u4e00-\u9fa5]");

  /// 邮箱 正则
  static RegExp emailExp = RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*.\w+([-.]\w+)*$");

  /// QQ邮箱 正则
  static RegExp qqEmailExp = RegExp(r'^[1-9]\d{4,10}@qq\.com$');

  /// URL正则
  static RegExp urlExp = RegExp(r"^((https|http|ftp|rtsp|mms)?://)[^\s]+");

  /// 身份证(15) 正则
  static RegExp idCard15Exp = RegExp(r"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}\$");

  /// 身份证(18) 正则
  static RegExp idCard18Exp = RegExp(r"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9Xx])\$");

  /// IP地址
  static RegExp ipAddressExp = RegExp(r"^((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)");

  /// 字母+数字 正则
  static RegExp pwd1Exp = RegExp(r"^[ZA-ZZa-z0-9_]+$");

  /// 小写字母+数字 正则
  static RegExp pwd2Exp = RegExp(r"^[Za-z0-9_]+$");

  /// 忽略特殊字符 正则
  static RegExp pwd3Exp = RegExp(r"^[\u4E00-\u9FA5A-Za-z0-9_]+$");

  /// 必须包含字母和数字(6~18位)正则
  static RegExp pwd4Exp = RegExp(r"^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{6,18}\$");

  /// 必须包含字母和数字,可包含特殊字符(6~18位) 正则
  static RegExp pwd5Exp = RegExp(r"^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z\\W]{6,18}\$");

  ///  必须包含字母和数字和殊字符(6~18位) 正则
  static RegExp pwd6Exp = RegExp(r"^(?![0-9]+\$)(?![a-zA-Z]+\$)(?![0-9a-zA-Z]+\$)(?![0-9\\W]+\$)(?![a-zA-Z\\W]+\$)[0-9A-Za-z\\W]{6,18}\$");
}

class RegExpUtil {
  /// 手机号(严谨)
  static bool matchPhone(String phone) {
    return RegExpConstants.mobilePhoneExp.hasMatch(phone);
  }

  /// 中文
  static bool matchChinese(String chinese) {
    return RegExpConstants.chineseExp.hasMatch(chinese);
  }

  /// 邮箱
  static bool matchEmail(String email) {
    return RegExpConstants.emailExp.hasMatch(email);
  }

  /// QQ邮箱
  static bool matchQQEmail(String email) {
    return RegExpConstants.qqEmailExp.hasMatch(email);
  }

  /// URL正则
  static bool matchUrl(String url) {
    return RegExpConstants.urlExp.hasMatch(url);
  }

  /// 身份证
  static bool matchIdCard(String idCard) {
    if (idCard.length == 15) {
      return RegExpConstants.idCard15Exp.hasMatch(idCard);
    } else if (idCard.length == 18) {
      return RegExpConstants.idCard18Exp.hasMatch(idCard);
    }
    return false;
  }

  /// IP地址
  static bool matchIpAddress(String ipAddress) {
    return RegExpConstants.ipAddressExp.hasMatch(ipAddress);
  }

  /// 字母+数字
  static bool matchPwd1(String pwd) {
    return RegExpConstants.pwd1Exp.hasMatch(pwd);
  }

  /// 小写字母+数字
  static bool matchPwd2(String pwd) {
    return RegExpConstants.pwd2Exp.hasMatch(pwd);
  }

  /// 忽略特殊字符
  static bool matchPwd3(String pwd) {
    return RegExpConstants.pwd3Exp.hasMatch(pwd);
  }

  /// 必须包含字母和数字(6~18位)正则
  static bool matchPwd4(String pwd) {
    return RegExpConstants.pwd4Exp.hasMatch(pwd);
  }

  /// 必须包含字母和数字,可包含特殊字符(6~18位)
  static bool matchPwd5(String pwd) {
    return RegExpConstants.pwd5Exp.hasMatch(pwd);
  }

  ///  必须包含字母和数字和殊字符(6~18位)
  static bool matchPwd6(String pwd) {
    return RegExpConstants.pwd6Exp.hasMatch(pwd);
  }

  /// TextField 限制输入数字类型
  static List<TextInputFormatter>? digitsOnly({int? maxLength}) {
    return [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(maxLength)];
  }

  /// TextField 限制单行输入
  static List<TextInputFormatter>? singleLine({int? maxLength}) {
    return [FilteringTextInputFormatter.singleLineFormatter, LengthLimitingTextInputFormatter(maxLength)];
  }
}
