import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'package:common_utils_v2/common_utils_v2.dart';

class ImagePickerUtil {
  /// 图片选择 单选(APP)
  static Future<String> pickSing({bool isCamera = true}) async {
    var path = "";

    try {
      PickedFile? image = await ImagePicker.platform.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (image != null && image.path.isNotEmpty) {
        path = image.path;
      } else {
        ToastUtil.showToast("取消");
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "camera_access_denied") {
          /// 相机权限被拒绝了
          PermissionUtil.requestCameraPermission();
        } else {
          printLog(StackTrace.current, e.toString());
          ToastUtil.showToast("取消");
        }
      } else {
        printLog(StackTrace.current, e.toString());
        ToastUtil.showToast("取消");
      }
    }
    return path;
  }

  /// 图片选择 多选(APP)
  static Future<List<String>> pickMulti() async {
    final List<String> pathList = [];
    try {
      List<PickedFile>? list = await ImagePicker.platform.pickMultiImage();
      if (list != null && list.isNotEmpty) {
        for (var item in list) {
          pathList.add(item.path);
        }
      } else {
        ToastUtil.showToast("取消");
      }
    } catch (e) {
      printLog(StackTrace.current, e.toString());
      ToastUtil.showToast("取消");
    }
    return pathList;
  }

  /// 图片选择(WEB/H5)
  static pickImageForWeb({required Function(List<html.File> files) onResult, String accept = "image/*", bool multiple = false}) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = accept;
    uploadInput.multiple = multiple;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      if (uploadInput.files != null && uploadInput.files!.isNotEmpty) {
        onResult(uploadInput.files!);
      } else {
        onResult([]);
      }
    });
  }
}
