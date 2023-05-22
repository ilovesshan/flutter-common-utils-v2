import 'package:common_utils_v2/common_utils_v2.dart';

class FileDownloadUtil {
  /// 下载图片
  static Future<void> downloadImage(String imageUrl, {bool isAsset = false, String fileName = ""}) async {
    Fluttertoast.showToast(msg: "下载中");
    try {
      var response = await Dio().get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: TextUtils.isEmptyWith(fileName, TimeUtil.currentTimeMillis().toString()));
      printLog(StackTrace.current, result);
      Fluttertoast.showToast(msg: "下载成功");
    } catch (e) {
      printLog(StackTrace.current, e);
      Fluttertoast.showToast(msg: "下载失败");
    }
  }

  /// 通用的文件下载
  static Future<String> downLoadFile(String remoteResourceUri) async {
    String extName = remoteResourceUri.substring(remoteResourceUri.lastIndexOf("/") + 1);
    Directory tempDir = await getTemporaryDirectory();
    String fileName = "${tempDir.path}/$extName";
    File file = File(fileName);
    final exists = await file.exists();
    if (exists) {
      return fileName;
    } else {
      try {
        Fluttertoast.showToast(msg: "缓冲中请稍后...");
        var response = await Dio().get(remoteResourceUri, options: Options(responseType: ResponseType.bytes));
        await file.create(recursive: true);
        await file.writeAsBytes(response.data);
        return fileName;
      } catch (e) {
        printLog(StackTrace.current, e);
        Fluttertoast.showToast(msg: "缓冲失败");
      }
    }
    return "";
  }
}
