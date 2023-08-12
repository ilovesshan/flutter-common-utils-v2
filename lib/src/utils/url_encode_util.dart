class UrlEncodeUtil {
  /// urlEncode 加码
  static String encode(String url) {
    return Uri.encodeComponent(url);
  }

  /// urlEncode 解码
  static String decode(String url) {
    return Uri.decodeComponent(url);
  }
}
