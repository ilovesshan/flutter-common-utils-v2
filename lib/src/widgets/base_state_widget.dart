import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class BaseStateWidget {

  /// 加载中...
  static Widget loadingWidget() {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 24.w, height: 24.w, child: const CircularProgressIndicator(strokeWidth: 1)),
          SizedBox(height: 20.h),
          Text("正在加载中...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666))),
        ],
      ),
    );
  }

  /// 数据为空...
  static Widget emptyWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh_outlined, color: Colors.grey, size: 24.w),
            SizedBox(height: 10.h),
            Text("数据一片空白...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666))),
          ],
        )
    );
  }

  /// 加载失败...
  static Widget errorWidget({VoidCallback? onRetry}) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.grey, size: 24.w),
            SizedBox(height: 10.h),
            Text("加载失败，轻触重试...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666))),
          ],
        ),
        onTap: () {
          if (onRetry != null) onRetry();
        },
      ),
    );
  }
}