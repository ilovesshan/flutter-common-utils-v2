import 'dart:io';
import 'package:flutter/material.dart';
import 'package:common_utils_v2/common_utils_v2.dart';

class ImagePreviewPage extends GetView<ImagePreviewController> {
  List<String> fileList;
  int currentIndex;

  ImagePreviewPage({required this.fileList, this.currentIndex = 0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ImagePreviewController());
    controller.bindData(fileList, currentIndex);
    return Material(
      color: Colors.black,
      child: Column(
        children: [
          /// 当前浏览图片索引位置
          Obx(
            () => Container(
              height: 100,
              alignment: Alignment.center,
              child: Text("${(controller.currentIndex.value + 1)}/${controller.fileList.length}", style: TextStyle(fontSize: 24.sp, color: Colors.white)),
            ),
          ),

          /// 图片预览区域
          Expanded(
            child: GestureDetector(
              child: PhotoViewGallery.builder(
                customSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  ImageProvider imageProvider;
                  var path = controller.fileList[index];
                  if (path.startsWith("https:") || path.startsWith("http:")) {
                    imageProvider = CachedNetworkImageProvider(path);
                  } else if (path.startsWith("assets/")) {
                    imageProvider = AssetImage(path);
                  } else {
                    imageProvider = FileImage(File(path));
                  }
                  return PhotoViewGalleryPageOptions(
                    basePosition: Alignment.center,
                    imageProvider: imageProvider,
                    initialScale: PhotoViewComputedScale.contained * 0.9,
                    heroAttributes: PhotoViewHeroAttributes(tag: const Uuid().v1().toString()),
                  );
                },
                itemCount: controller.fileList.length,
                loadingBuilder: (context, event) => SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30.w, height: 30.w, child: const CircularProgressIndicator(strokeWidth: 1)),
                      SizedBox(height: 20.h),
                      Text("正在加载中...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFFFFFFFF))),
                    ],
                  ),
                ),
                pageController: controller.pageController,
                onPageChanged: (index) {
                  controller.currentIndex.value = index;
                },
              ),
              onTap: () => Get.back(),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Container(
                              width: Get.width,
                              height: 50.h,
                              padding: EdgeInsets.only(left: 8.w),
                              alignment: Alignment.centerLeft,
                              child: Text('保存图片', style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            ),
                            onTap: () async {
                              Get.back();
                              await FileDownloadUtil.downloadImage(controller.fileList[controller.currentIndex.value]);
                            },
                          ),
                          const Divider(color: Color(0xffe2e2e2)),
                          InkWell(
                            child: Container(
                              width: Get.width,
                              height: 50.h,
                              padding: EdgeInsets.only(left: 8.w),
                              alignment: Alignment.centerLeft,
                              child: Text('取消', style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            ),
                            onTap: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePreviewController extends GetxController {
  var fileList = [].obs;
  var currentIndex = 0.obs;
  PageController pageController = PageController();

  void bindData(List<String> fileList, int currentIndex) {
    this.fileList.value = fileList;
    this.currentIndex.value = currentIndex;
    pageController = PageController(initialPage: currentIndex);
  }
}
