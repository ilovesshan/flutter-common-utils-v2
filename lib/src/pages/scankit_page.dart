import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:common_utils_v2/common_utils_v2.dart';



/// 扫码插件 支持从相册选取
class ScanKitPage extends StatefulWidget {
  const ScanKitPage({Key? key}) : super(key: key);

  @override
  State<ScanKitPage> createState() => _ScanKitPageState();
}

class _ScanKitPageState extends State<ScanKitPage> {
  late ScanKitController _controller;

  final screenWidth = window.physicalSize.width;
  final screenHeight = window.physicalSize.height;


  bool isFirstLoadedResult = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pixelSize = 375 * window.devicePixelRatio;
    var left = screenWidth / 2 - pixelSize / 2;
    var top = screenHeight / 2 - pixelSize / 2;
    var right = screenWidth / 2 + pixelSize / 2;
    var bottom = screenHeight / 2 + pixelSize / 2;
    var rect = Rect.fromLTRB(left, top, right, bottom);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
      body: SafeArea(
        child: Stack(
          children: [
            /// 使用 ScanKitWidget 实现扫码，可自定义扫码页面视图
            ScanKitWidget(
              callback: (controller) {
                _controller = controller;
                _controller.onResult.listen((result) {
                  if(isFirstLoadedResult){
                    Navigator.of(context).pop(result);
                    isFirstLoadedResult = false;
                  ToastUtil.show("扫描成功");
                  }
                }).onError((error){
                ToastUtil.show("异常：${error.toString()}");
                });
              },
              continuouslyScan: false,
              boundingBox: rect,
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Image.asset("assets/common/nav-back-white.png", width: 10.w, height: 18.h,scale: 4,),
                    onPressed: ()=> Navigator.of(context).pop()
                  ),

                  Text("扫一扫", style: TextStyle(fontSize: 14.sp, color: Colors.white)),

                  IconButton(
                    onPressed: ()=> _controller.switchLight(),
                    icon: const Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 24),
                  ),
                ],
              ),
            ),

            /// 扫码区域
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 375, height: 300, margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(border:Border.all(color: const Color(0xFFFF8C17), width: 1),),
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
                  width: 375, height: 150, margin: const EdgeInsets.all(4), alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Text("相册选取", style: TextStyle(fontSize: 14, color: Colors.white)),
                        onTap: () => _controller.pickPhoto(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}