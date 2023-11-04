// import 'dart:html' as html;
import 'package:common_utils_v2/common_utils_v2.dart';

/// 文件上传工具类
class FileUploadUtil {
  static final HttpHelperUtil _helperUtil = HttpHelperUtil.instance;

  /// 单文件上传(APP)
  static Future<BaseModel> uploadSingle({
    required String filePath,
    String requestUrl = "/attachment",
    String fileKey = "file",
    needLoading = true,
    bool needToken = true,
    String loadingText = "图片上传中...",
    CancelToken? cancelToken,
    Map<String, String> extra = const {},
  }) async {
    FormData formData = FormData.fromMap({fileKey: MultipartFile.fromFileSync(filePath), ...extra});
    try {
      var response = await _helperUtil.post(requestUrl, data: formData,
          needToken: needToken,
          needLoading: needLoading,
          cancelToken: cancelToken,
          loadingText: loadingText);
      return response;
    } catch (e) {
      Log.e("文件上传失败: $e");
      return BaseModel(code: -200, data: []);
    }
  }

  /// 多文件上传(APP)
  static Future<BaseModel> uploadMultiple({
    required List<String> filePathList,
    String requestUrl = "/attachment",
    String fileKey = "file",
    needLoading = true,
    bool needToken = true,
    String loadingText = "图片上传中...",
    CancelToken? cancelToken,
    Map<String, String> extra = const {},
  }) async {
    var formData = FormData.fromMap({
      fileKey: filePathList.map((path) => MultipartFile.fromFileSync(path)).toList(),
      ...extra,
    });
    try {
      var response = await _helperUtil.post(requestUrl, data: formData,
          needToken: needToken,
          needLoading: needLoading,
          cancelToken: cancelToken,
          loadingText: loadingText);
      return response;
    } catch (e) {
      Log.e("文件上传失败: $e");
      return BaseModel(code: -200, data: []);
    }
  }

  /// 删除文件
  static Future<BaseModel> deleteFile({
    required String id,
    String requestUrl = "/attachment",
    String fileKey = "id",
    needLoading = true,
    String loadingText = "图片删除中...",
    bool needToken = true,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _helperUtil.delete(requestUrl, queryParameters: {fileKey: id},
          needToken: needToken,
          needLoading: needLoading,
          cancelToken: cancelToken,
          loadingText: loadingText);
      return response;
    } catch (e) {
      Log.e("文件删除失败: $e");
      return BaseModel(code: -200, data: []);
    }
  }


/// 多文件上传(WEB/H5)
// static Future<dynamic> uploadFilesForWeb({String requestUrl = "/attachment", String fileKey = "file", required List<html.File> files, Map<String, String> extra = const {}}) async {
//   List<MultipartFile> multipartFiles = [];
//   for (var file in files) {
//     var reader = html.FileReader();
//     reader.readAsArrayBuffer(file);
//     await reader.onLoadEnd.first;
//     var fileBytes = reader.result as List<int>;
//     var multipartFile = MultipartFile.fromBytes(fileBytes, filename: file.name);
//     multipartFiles.add(multipartFile);
//   }
//   var formData = FormData.fromMap({fileKey: multipartFiles, ...extra});
//   try {
//     final BaseModel response = await _helperUtil.post(requestUrl, data: formData);
//     return response.data;
//   } catch (e) {
//     Log.e("文件上传失败: $e");
//     return "";
//   }
// }

}
