import 'package:flutter/material.dart';
import 'package:common_utils_v2/common_utils_v2.dart';

typedef OnResult = void Function(String result);

/// 常用底部弹框选择器
class CommonBottomSheetSelector {
  /// data 数据
  /// onResult 回调的index
  static void showTextItem({required List<CommonBottomSheetTextModel> data, required OnResult onResult}) {
    Get.bottomSheet(
      Container(
        height: 260.h,
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(data.length, (index) {
              return Column(
                children: [
                  ListTile(
                    title: Text("${data[index].name}", textAlign: TextAlign.center),
                    onTap: () async {
                      onResult(data[index].id);
                      Get.back();
                    },
                  ),
                  const Divider(height: 0.0, indent: 0.0, color: Color(0xFFE6E6E6))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  /// data 数据
  /// onResult 回调的index
  static void showIconItem({required List<CommonBottomSheetIconModel> data, required OnResult onResult}) {
    Get.bottomSheet(Container(
      height: 260.h,
      padding: EdgeInsets.symmetric(vertical: 10),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: GridView.count(
        childAspectRatio: 5 / 4,
        crossAxisCount: 4,
        children: List.generate(data.length, (index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [Icon(data[index].icon), Text(CommonBottomSheetConstants.commonBottomSheetIconList[index].name)],
              ),
            ),
            onTap: () async {
              onResult(data[index].id);
              Get.back();
            },
          );
        }),
      ),
    ));
  }
}
