###  flutter-common-utils-v2

### 1、简介

+ flutter-common-utils-v2：基于flutter框架封装的一个通用工具包，里面包含了日常开发中的常用工具类以及通用Widget，里面主要集成了较为流行的三方插件并做了一层简单封装，具体可以查看pub文件清单。
+ flutter-common-utils-v2相较于flutter-common-utils更加轻量级。



### 2、导入

+ 将项目clone到本地进入导入

  ```
  common_utils_v2:
    path: ./flutter-common-utils-v2
  ```

  

+ 通过 git远程方式导入

  ```
  common_utils_v2:
    git:
      url: https://github.com/ilovesshan/flutter-common-utils-v2.git
      ref: master
  ```

  

### 3、使用

+ 在项目入口文件main.dart进行配置

  ```dart
  import 'package:app/router/router.dart';
  import 'package:common_utils/common_utils.dart';
  import 'package:flutter/material.dart';
  
  void main() {
      runApp(const RootApplication());
  }
  
  class RootApplication extends StatefulWidget {
      const RootApplication({Key? key}) : super(key: key);
  
      @override
      State<RootApplication> createState() => _RootApplicationState();
  }
  
  class _RootApplicationState extends State<RootApplication> {
      @override
      Widget build(BuildContext context) {
          // 使用 GetMaterialApp
          return GetMaterialApp(
              // APP主题配色方案
              theme: AppInitialize.appTheme(),
              // 路由解决方案(也可自行配置)
              initialRoute: YFRouter.splash,
              getPages: YFRouter.routes(),
              builder: (_, c) {
                  // android状态栏为透明沉浸式
                  AppInitialize.setSystemUiOverlayStyle();
                  // 屏幕适配
                  AppInitialize.initScreenUtil(_);
                  return FlutterEasyLoading(
                      child: GestureDetector(
                          child: c!,
                          // 处理键盘
                          onTap: ()=> AppInitialize.closeKeyBord(context)
                      ),
                  );
              },
          );
      }
  }
  
  ```

+ 路由文件信息(仅供参考)

  ```dart
  class AppRouter {
      static const String splash = "/splash";
      static const String login = "/login";
      static const String menuContainer = "/menuContainer";
  
      static List<GetPage> routes() {
          return [
              GetPage(name: splash, page: () => const SplashPage()),
              GetPage(name: menuContainer, page: () => const MenuContainer()),
              GetPage(name: login, page: () => const LoginPage()),
          ];
      }
      static onUnknownRoute() {}
  }
  ```

  



### 5、启动过程中可能发生的错误

+ `uses-sdk:minSdkVersion 16 cannot be smaller than version 19 declared in library`

  ```groovy
  minSdkVersion 19
  ```

  

+ `Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && hasPermissionInManifest(context, null, permission ) `

  ```groovy
  compileSdkVersion 31
  targetSdkVersion 31
  ```

  

+ `com.android.builder.dexing.DexArchiveMergerException: Error while merging dex archives: 
  The number of method references in a .dex file cannot exceed 64K.1`

  ```groovy
  android {
      //...
      defaultConfig {
          //...
          multiDexEnabled true
      }
  }
  ```

  ```groovy
  dependencies{
  	implementation 'androidx.multidex:multidex: 2.0.1'
  }
  ```

  

  



### 6、最后

本项目工具库会长期更新维护下去...
