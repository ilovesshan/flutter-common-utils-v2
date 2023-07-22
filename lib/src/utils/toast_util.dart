import 'package:flutter/material.dart';
import 'package:common_utils_v2/common_utils_v2.dart';

class ToastUtil {
  /// Fluttertoast
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  /// Fluttertoast Custom
  static showCustom(String msg, {double? opacity}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(opacity ?? 0.5),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// BotToast
  static void showToast(String msg) {
    BotToast.showText(text: msg);
  }
}
