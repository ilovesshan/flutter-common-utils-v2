import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

class ToastUtil {
  static show(String text) {
    Fluttertoast.showToast(msg: text);
  }

  static showCustom(String text, {double? opacity}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(opacity ?? 0.5),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
