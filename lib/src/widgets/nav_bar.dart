import 'package:common_utils_v2/common_utils_v2.dart';

class NavBar {
  static AppBar show(String text, { List<Widget>? actions, PreferredSizeWidget? bottom}){
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      title: Text(text, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF222222), fontWeight: FontWeight.bold)),backgroundColor: Colors.white, centerTitle: true, elevation: 0,
      leading: GestureDetector(
        child: Container(padding: EdgeInsets.all(20.w), child: Image.asset("assets/common/nav-back-black.png")),
        onTap: ()=> Get.back(),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  static AppBar showWidthPrimaryTheme(String text, { List<Widget>? actions, PreferredSizeWidget? bottom}){
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      title: Text(text, style: TextStyle(fontSize: 14.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),backgroundColor: Get.theme.primaryColor, centerTitle: true, elevation: 0,
      leading: GestureDetector(
        child: Container(padding: EdgeInsets.all(20.w), child: Image.asset("assets/common/nav-back-white.png")),
        onTap: ()=> Get.back(),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}