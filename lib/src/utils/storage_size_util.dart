class StorageSizeUtil {
  /// 根据bytes 计算对应的B/KB/MB/GB值
  static getPrintSize(bytes) {
    String size = "";
    if (bytes < 0.1 * 1024) {
      /// 小于0.1KB，则转化成B
      size = bytes.toString();
      size = size.substring(0, size.indexOf(".") + 3) + " B";
    } else if (bytes < 0.1 * 1024 * 1024) {
      /// 小于0.1MB，则转化成KB
      size = (bytes / 1024).toString();
      size = size.substring(0, size.indexOf(".") + 3) + " KB";
    } else if (bytes < 0.1 * 1024 * 1024 * 1024) {
      /// 小于0.1GB，则转化成MB
      size = (bytes / (1024 * 1024)).toString();
      size = size.substring(0, size.indexOf(".") + 3) + " MB";
    } else {
      /// 其他转化成GB
      size = (bytes / (1024 * 1024 * 1024)).toString();
      size = size.substring(0, size.indexOf(".") + 3) + " GB";
    }
    return size;
  }
}
