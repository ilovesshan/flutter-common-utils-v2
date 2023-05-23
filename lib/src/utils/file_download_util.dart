import 'dart:io';
import 'dart:typed_data';

import 'package:common_utils_v2/common_utils_v2.dart';

class FileDownloadUtil {
  /// 下载图片
  static Future<void> downloadImage(String imageUrl, {bool isAsset = false, String fileName = ""}) async {
    ToastUtil.show("下载中");
    try {
      var response = await Dio().get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: TextUtil.isEmptyWith(fileName, TimeUtil.currentTimeMillis().toString()));
      printLog(StackTrace.current, result);
      ToastUtil.show("下载成功");
    } catch (e) {
      printLog(StackTrace.current, e);
      ToastUtil.show("下载失败");
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
        ToastUtil.show("缓冲中请稍后...");
        var response = await Dio().get(remoteResourceUri, options: Options(responseType: ResponseType.bytes));
        await file.create(recursive: true);
        await file.writeAsBytes(response.data);
        return fileName;
      } catch (e) {
        printLog(StackTrace.current, e);
        ToastUtil.show("缓冲失败");
      }
    }
    return "";
  }
}
