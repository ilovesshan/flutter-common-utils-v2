import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:common_utils_v2/common_utils_v2.dart';

/// 扫码插件 支持从相册选取
class ScanKitPage extends GetView<ScanKitPageController> {
  const ScanKitPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ScanKitPageController());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
      body: controller.obx(
        (state) => SafeArea(
          child: Obx(
            () => Stack(
              children: [
                /// 使用 ScanKitWidget 实现扫码，可自定义扫码页面视图
                ScanKitWidget(controller: controller.ctrl, continuouslyScan: false, boundingBox: controller.rect.value),

                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                      ),
                      Text("扫一扫", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                      IconButton(
                        onPressed: () => controller.ctrl.switchLight(),
                        icon: const Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                ),

                /// 扫码区域
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 375,
                    height: 300,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(border: Border.all(color: const Color(0xFFFF8C17), width: 1)),
                  ),
                ),

                /// 底部操作按钮
                Positioned(
                  bottom: 30,
                  left: 4,
                  right: 4,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      // color: Color.fromRGBO(0, 0, 0, 0.3),
                      width: 375,
                      height: 150,
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: const Text("相册选取", style: TextStyle(fontSize: 14, color: Colors.white)),
                            onTap: () => controller.ctrl.pickPhoto(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onLoading: BaseStateWidget.loadingWidget(),
      ),
    );
  }
}

class ScanKitPageController extends GetxController with StateMixin {
  final ScanKitController ctrl = ScanKitController();
  var boxSize = 200.00;
  Rx<Rect> rect = Rect.zero.obs;

  @override
  void onInit() {
    super.onInit();
    bindData();
  }

  void bindData() async {
    change({}, status: RxStatus.loading());
    var size = View.of(Get.context!).display.size;
    var left = size.width / 2 - boxSize / 2;
    var top = size.height / 2 - boxSize / 2;
    rect.value = Rect.fromLTWH(left, top, boxSize, boxSize);
    ctrl.onResult.listen((result) {
      Log.v("scanning result:value=${result.originalValue} scanType=${result.scanType}");
      if (TextUtil.isNotEmpty(result.originalValue)) {
        Get.back(result: {"result": result.originalValue, "scanType": result.scanType});
      }
    });
    change({}, status: RxStatus.success());
  }

  @override
  void onClose() {
    ctrl.dispose();
    super.onClose();
  }
}
