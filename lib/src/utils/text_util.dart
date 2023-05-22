class TextUtils {
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
    return ( text.isEmpty || text == null || text == "null") ? defaultValue : text ;
  }
}