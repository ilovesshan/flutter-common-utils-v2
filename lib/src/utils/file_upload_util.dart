import 'package:common_utils_v2/common_utils_v2.dart';

/// 文件上传工具类
class FileUploadUtil {
  static final HttpHelperUtil _helperUtil = HttpHelperUtil.instance;

  static List<CommonBottomSheetResultModel> pickerOptions = [
    CommonBottomSheetResultModel(name: "拍照上传", value: "0"),
    CommonBottomSheetResultModel(name: "相册选取", value: "1"),
    CommonBottomSheetResultModel(name: "取消", value: "2")
  ];

  /// 单文件上传
  static Future<dynamic> uploadSingle({required String uploadPath, required String filePath}) async {
    MultipartFile image = MultipartFile.fromFileSync(filePath);
    FormData formData = FormData.fromMap({"file": image});
    try {
      final Map<String, dynamic> response = await _helperUtil.post("", data: formData);
      Future.value(response["data"]);
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
      final Map<String, dynamic> response = await _helperUtil.post("", data: formData);
      Future.value(response["data"]);
    } catch (e) {
      Future.error(e);
    }
  }

  /// 删除文件
  static Future<dynamic> deleteFile({required String id}) async {
    try {
      final Map<String, dynamic> response = await _helperUtil.delete("", queryParameters: {"id": id});
      Future.value(response["data"]);
    } catch (e) {
      Future.error(e);
    }
  }
}
