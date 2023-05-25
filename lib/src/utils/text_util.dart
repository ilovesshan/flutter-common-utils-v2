class TextUtil {
  /// 判断数据是否是空的
  static bool isEmpty(String text) {
    text = text.trim();
    return (text.isEmpty || text == null || text == "null");
  }

  /// 判断数据是否不是空
  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }

  /// 判断数据是否是空 如果空则给予一个默认值返回
  static String isEmptyWith(String text, String defaultValue) {
    text = text.trim();
    return (text.isEmpty || text == null || text == "null") ? defaultValue : text;
  }

  /// 将指定位置的字符串替换成****
  static String hideNumber(String phoneNo, {int start = 3, int end = 7, String replacement = '****'}) {
    return phoneNo.replaceRange(start, end, replacement);
  }

  /// 字符串替换
  static String replace(String text, Pattern pattern, String replace) {
    return text.replaceAll(pattern, replace);
  }

  /// 字符串分割
  static List<String> split(String text, Pattern pattern) {
    return text.split(pattern);
  }

  /// 字符串反转
  static String reverse(String text) {
    if (isEmpty(text)) return '';
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }
}
