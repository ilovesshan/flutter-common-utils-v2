import 'package:common_utils_v2/common_utils_v2.dart';

typedef OnResult = void Function (int result);

/// 常用底部弹框选择器
class CommonBottomSheetSelector{
  /// data 数据
  /// onResult 选择了结果的回调返回index
  static void show({required List<CommonBottomSheetResultModel> data, required OnResult onResult}) {
    Get.bottomSheet(
      Container(
        height: 260.h, color: const Color.fromRGBO(255, 255, 255, 1),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(data.length, (index){
              return Column(
                children:[
                  ListTile(title: Text("${data[index].name}", textAlign: TextAlign.center), onTap: () async {
                    onResult(index);
                    Get.back();
                  }),
                  const Divider(height: 0.0, indent: 0.0, color: Color(0xFFE6E6E6))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}