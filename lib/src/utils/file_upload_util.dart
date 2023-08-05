import 'package:common_utils_v2/common_utils_v2.dart';

/// 文件上传工具类
class FileUploadUtil {
  static final HttpHelperUtil _helperUtil = HttpHelperUtil.instance;

  /// 单文件上传
  static Future<dynamic> uploadSingle({required String filePath}) async {
    MultipartFile image = MultipartFile.fromFileSync(filePath);
    FormData formData = FormData.fromMap({"file": image});
    try {
      final BaseModel response = await _helperUtil.post("/attachment", data: formData);
      return response.data;
    } catch (e) {
      Future.error(e);
    }
  }

  /// 多文件上传
  static Future<dynamic> uploadMultiple({required List<String> filePathList, required String id}) async {
    FormData formData = FormData();
    for (var path in filePathList) {
      MapEntry<String, MultipartFile> mapEntry = MapEntry("file", MultipartFile.fromFileSync(path));
      formData.files.add(mapEntry);
    }
    try {
      final BaseModel response = await _helperUtil.post("/attachment", data: formData);
      return response.data;
    } catch (e) {
      Future.error(e);
    }
  }

  /// 删除文件
  static Future<dynamic> deleteFile({required String id}) async {
    try {
      final BaseModel response = await _helperUtil.delete("/attachment", queryParameters: {"id": id});
      return response.data;
    } catch (e) {
      Future.error(e);
    }
  }
}
