import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:common_utils_v2/common_utils_v2.dart';

class FileCompressUtil {

  /// compress file and get file.
  static Future<File> compressAndGetFile(File file) async {
    int fileSize = file.lengthSync();

    /// 文件小于200kb就不压缩
    if (fileSize < 200 * 1024) {
      return file;
    }
    Log.d("压缩前大小(compress file to another new file): ${StorageSizeUtil.getPrintSize(fileSize)}， $fileSize Byte， 文件路径：${file.path}");

    /// 根据图片大小计算 quality(质量)
    int quality = getQualityBySize(fileSize);

    /// 获取一个临时目录用来存放压缩后的文件
    var dir = await getTemporaryDirectory();
    var targetPath = dir.absolute.path + "/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    var result = await FlutterImageCompressCommon().compressAndGetFile(file.absolute.path, targetPath, minWidth: 600, quality: quality, rotate: 0);
    File compressResult = File(result!.path);
    Log.d("压缩后大小(compress file to another new file): ${StorageSizeUtil.getPrintSize(compressResult.lengthSync())}， ${compressResult.lengthSync()} Byte， 文件路径：${compressResult.path}");
    return compressResult;
  }

  /// compress file and get Uint8List
  static Future<Uint8List> compressWithFile(File file) async {
    int fileSize = file.lengthSync();

    /// 文件小于200kb就不压缩
    if (fileSize < 200 * 1024) {
      return await file.readAsBytes();
    }
    Log.d("压缩前大小(compress file to Uint8List): ${StorageSizeUtil.getPrintSize(fileSize)}， $fileSize Byte， 文件路径：${file.path}");

    /// 根据图片大小计算quality(质量)
    int quality = getQualityBySize(fileSize);
    var result = await FlutterImageCompressCommon().compressWithFile(file.absolute.path, minWidth: 600, quality: quality, rotate: 0);
    Log.d("压缩后大小(compress file to Uint8List): ${StorageSizeUtil.getPrintSize(result!.length)}， ${result.length} Byte");
    return result;
  }

  /// compress asset and get Uint8List.
  static Future<Uint8List> compressAssetImage(String assetName) async {
    ByteData byteData = await rootBundle.load(assetName);
    int fileSize = byteData.lengthInBytes;

    /// 文件小于200kb就不压缩
    if (fileSize < 200 * 1024) {
      return Uint8List(fileSize);
    }
    Log.d("压缩前大小(compress asset to Uint8List): ${StorageSizeUtil.getPrintSize(fileSize)}， $fileSize Byte， 文件路径：$assetName");

    /// 根据图片大小计算quality(质量)
    int quality = getQualityBySize(fileSize);
    var uint8ListResult = await FlutterImageCompressCommon().compressAssetImage(assetName, minWidth: 600, quality: quality, rotate: 0);
    Log.d("压缩后大小(compress file to Uint8List): ${StorageSizeUtil.getPrintSize(uint8ListResult!.length)}， ${uint8ListResult.length} Byte");
    return uint8ListResult;
  }

  /// compress Uint8List and get another Uint8List.
  static Future<Uint8List> compressWithList(Uint8List uint8list) async {
    /// 文件小于200kb就不压缩
    if (uint8list.length < 200 * 1024) {
      return Uint8List(uint8list.length);
    }
    Log.d("压缩前大小(compress Uint8List to another new Uint8List): ${StorageSizeUtil.getPrintSize(uint8list.length)}， ${uint8list.length} Byte");

    /// 根据图片大小计算quality(质量)
    int quality = getQualityBySize(uint8list.length);
    var uint8ListResult = await FlutterImageCompressCommon().compressWithList(uint8list, minWidth: 600, quality: quality, rotate: 0);
    Log.d("压缩后大小(compress Uint8List to another new Uint8List): ${StorageSizeUtil.getPrintSize(uint8ListResult.length)}， ${uint8ListResult.length} Byte");
    return uint8ListResult;
  }

  /// 根据图片大小计算 quality(质量)
  static int getQualityBySize(int size) {
    var quality = 100;

    /// 大于4M
    if (size > 4 * 1024 * 1024) {
      quality = 50;

      /// 大于2M
    } else if (size > 2 * 1024 * 1024) {
      quality = 60;

      /// 大于1M
    } else if (size > 1 * 1024 * 1024) {
      quality = 70;

      /// 大于0.5M
    } else if (size > 0.5 * 1024 * 1024) {
      quality = 80;

      /// 大于0.25M
    } else if (size > 0.25 * 1024 * 1024) {
      quality = 90;
    }
    return quality;
  }
}
