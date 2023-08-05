import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:common_utils_v2/common_utils_v2.dart';

class FileDownloadUtil {
  /// 下载图片
  static Future<dynamic> downloadImage(String remoteResourceUri, {String fileName = "", String ext = "png", bool isAsset = false, bool showLoading = true}) async {
    if (showLoading) {
      LoadingUtil.showLoading(msg: "下载中...");
    }
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      var response = await Dio().get(remoteResourceUri, options: Options(responseType: ResponseType.bytes));
      String saveFileName = TextUtil.isEmpty(fileName) ? "${directory.path}/$fileName" : "${directory.path}/${TimeUtil.currentTimeMillis()}.$ext";
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 80, name: saveFileName);
      Log.d(result);
      if (showLoading) {
        ToastUtil.showToast("下载成功");
      }
      return result;
    } catch (e) {
      Log.e(e.toString(), e);
      if (showLoading) {
        ToastUtil.showToast("下载失败");
      }
    } finally {
      if (showLoading) {
        LoadingUtil.hideAllLoading();
      }
    }
  }

  /// 下载图片 保存ui.Image类型(一般用于水印)
  static Future<dynamic> downloadImageByUIImage(ui.Image image, {String fileName = "", String ext = "png", bool showLoading = true}) async {
    if (showLoading) {
      LoadingUtil.showLoading(msg: "下载中...");
    }
    try {
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      Directory directory = await getApplicationDocumentsDirectory();
      String saveFileName = TextUtil.isEmpty(fileName) ? "${directory.path}/$fileName" : "${directory.path}/${TimeUtil.currentTimeMillis()}.$ext";
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes), quality: 100, name: saveFileName);
      Log.d(result);
      if (showLoading) {
        ToastUtil.showToast("下载成功");
      }
      return result;
    } catch (e) {
      Log.e(e.toString(), e);
      if (showLoading) {
        ToastUtil.showToast("下载失败");
      }
    } finally {
      if (showLoading) {
        LoadingUtil.hideAllLoading();
      }
    }
  }

  /// 通用的文件下载
  static Future<String> downLoadFile(String remoteResourceUri, {bool showLoading = true}) async {
    String extName = remoteResourceUri.substring(remoteResourceUri.lastIndexOf("/") + 1);
    Directory tempDir = await getTemporaryDirectory();
    String fileName = "${tempDir.path}/$extName";
    File file = File(fileName);
    final exists = await file.exists();
    if (exists) {
      return fileName;
    } else {
      CancelToken cancelToken = CancelToken();
      bool isCanceled = false;
      try {
        if (showLoading) {
          LoadingUtil.showLoading(
            msg: "下载中...",
            onClose: () {
              isCanceled = true;
              cancelToken.cancel();
            },
          );
        }
        var response = await Dio().get(remoteResourceUri, options: Options(responseType: ResponseType.bytes), cancelToken: cancelToken);
        await file.create(recursive: true);
        await file.writeAsBytes(response.data);
        return fileName;
      } catch (e) {
        if (!isCanceled) {
          Log.e(e);
          ToastUtil.showToast("下载中失败");
        }
      } finally {
        if (showLoading) {
          LoadingUtil.hideAllLoading();
        }
      }
    }
    return "";
  }
}
