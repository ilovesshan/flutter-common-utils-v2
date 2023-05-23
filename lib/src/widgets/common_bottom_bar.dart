import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

class CommonBottomBar {
  /// 顶部appBar
  static AppBar showAppBar(String text, { List<Widget>? actions, PreferredSizeWidget? bottom}){
    return AppBar(
      title: Text(text, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF222222), fontWeight: FontWeight.bold)),backgroundColor: Colors.white, centerTitle: true, elevation: 0,
      leading: GestureDetector(
        child: Container(padding: EdgeInsets.all(20.w), child: Image.asset("assets/common/nav-back-black.png")),
        onTap: ()=> Get.back(),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  /// 带小红点的tabBar Item
  static Widget buildTabBarItemWithBadge(String iconPath, int unReadCount) {
    if( unReadCount == 0){
      // 未读数量为0 不显示小红点
      return buildTabBarItem(iconPath);
    }else{
      return Badge(
        padding: EdgeInsets.all(unReadCount >= 10 ? 2.r : 5.r),
        position: BadgePosition(top: unReadCount >= 10 ? -8 : -12, start: 15),
        badgeContent:Text("$unReadCount", style: TextStyle(color: Colors.white, fontSize: unReadCount >= 10 ? 12.sp : 14.sp)),
        child: Image.asset(iconPath, width: 21.w, height: 21.w),
      );
    }
  }

  /// 普通tabBar Item
  static Widget buildTabBarItem (String iconPath) {
    return  Image.asset(iconPath, width: 21.w, height: 21.w);
  }
}