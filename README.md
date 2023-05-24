##  flutter-common-utils-v2

### 1、简介

+ `flutter-common-utils-v2`：基于`dart API`以及常用的三方插件封装的一个工具包，里面主要封装了日常开发中常用的工具类以及通用Widget/page，工具包中对一些三方插件做了一层简单封装，具体引用可以查看pub文件清单。
+ `flutter-common-utils-v2`相较于`flutter-common-utils`更加轻量级。
+ `flutter-common-utils-v2` 能力简单介绍：
  + 小部件
    +  AppBar
    +  BottomBar
    + 底部弹框选择器
    + 跑马灯
    +  轮播图
    + ...
  + 页面
    + 图片预览
    + WebView
    + ...
  + 工具类
    + App配置信息
    + 颜色转换工具
    + 网络状态检测
    + 设备信息获取
    + 基于发布订阅模式的EventBus
    + 文件上传/文件下载
    + Dio网络请求封装
    + 图片/拍摄选择器
    + 日志输出
    + 调用三方地图导航（高德、百度、腾讯）
    + 权限申请
    + 扫二维码/条形码
    + 音频录制/播放
    + RSA加密
    + SharedPreferences封装
    + 文本判空与填充
    + 时间日期转换
    + Toast轻提示
    + APP更新
    + ...

### 2、导入

+  `flutter-common-utils-v2` 工具包引用版本说明

  + flutter版本： `2.5.0` 

  +  Dart sdk 版本： `2.14.0`

    ```bash
    Flutter 2.5.0 • channel stable • https://github.com/flutter/flutter.git
    Framework • revision 4cc385b4b8 (1 year, 8 months ago) • 2021-09-07 23:01:49 -0700
    Engine • revision f0826da7ef
    Tools • Dart 2.14.0
    ```

    

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

  

### 3、基本配置

+ 在项目入口文件`main.dart`进行配置（可以直接copy，再按需求修改即可）

  ```dart
  import 'package:flutter/material.dart';
  import 'package:common_utils_v2/common_utils_v2.dart';
  
  import 'package:getx_app/router/router.dart';
  
  
  void main() async {
    runApp(const RootApplication());
  
    /// 初始化 SharedPreferences工具类
    await SpUtil.initSharedPreferences();
  }
  
  class RootApplication extends StatefulWidget {
    const RootApplication({Key? key}) : super(key: key);
  
    @override
    State<RootApplication> createState() => _RootApplicationState();
  }
  
  class _RootApplicationState extends State<RootApplication> {
    @override
    Widget build(BuildContext context) {
      /// 使用 GetMaterialApp替换MaterialApp
      return GetMaterialApp(
        /// APP主题配色方案
        theme: AppInitialize.appTheme(),
        /// 使用Get提供的路由解决方案(也可自行选择其他三方库)
        initialRoute: AppRouter.initRoute,
        getPages: AppRouter.routes(),
        navigatorKey: Get.key,
        onUnknownRoute: (routeSettings) => AppRouter.onUnknownRoute(routeSettings),
        routingCallback: (routing) => AppRouter.routingCallback(routing!),
        navigatorObservers: [
          /// 如果未使用GetMaterialApp ,则可以通过navigatorObservers来观察路由变化
          GetObserver()
        ],
        /// 初始化时注入Bindings
        initialBinding: InitBinding(),
        /// Get控制器的管理机制,默认 SmartManagement.full
        smartManagement: SmartManagement.full,
        builder: (context, child) {
          /// android状态栏为透明沉浸式
          AppInitialize.setSystemUiOverlayStyle();
          /// 屏幕适配
          AppInitialize.initScreenUtil(context);
          return FlutterEasyLoading(
            child: GestureDetector(
              child: child!,
              /// 点击空白区域关闭键盘
              onTap: () => AppInitialize.closeKeyBord(context),
            ),
          );
        },
      );
    }
  }
  
  /// 初始化时注入Bindings（全局声明）
  class InitBinding implements Bindings {
    @override
    void dependencies() {
       /// 注入控制器...
    }
  }
  
  ```

  

+ 路由文件信息(仅供参考)

  ```dart
  import 'package:flutter/material.dart';
  import 'package:common_utils_v2/common_utils_v2.dart';
  
  
  class AppRouter {
    static const String initRoute = home;
    static const String splash = "/splash";
    static const String home = "/main";
    static const String goodsDetail = "/goodsDetail";
  
    /// 路由表
    static List<GetPage> routes() {
      return [
        /// binding / bindings 是可选的根据业务需求选择合适的解决方案即可
        GetPage(name: splash, page: () => SplashPage(), binding: SplashBinding()),
        GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
        /// 命名路由传参方式
        GetPage(name: "$goodsDetail/:id", page: () => GoodsDetailPage(), bindings: const []),
      ];
    }
  
    /// 404路由
    static Route<dynamic>? onUnknownRoute(RouteSettings routeSettings) {
      return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) => const Scaffold(body: Center(child: Text('Not Found'))),
      );
    }
  
    /// 路由拦截
    static ValueChanged<Routing?>? routingCallback(Routing routing) {
      if (routing.current == AppRouter.splash) {
        /// 做业务处理...
      }
    }
  }
  ```
  
  
  
+ bingding类(仅供参考)

  ```dart
  /// Controller
  class CountController extends GetxController {
    final count = 0.obs;
    increment() => count.value++;
  }
  
  /// Binding
  class HomeBinding extends Bindings {
    @override
    void dependencies() {
      Get.lazyPut(() => CountController());
    }
  }
  ```
  
  
  
  ```dart
  class SplashBinding extends Bindings {
    @override
    void dependencies() {
      /// 注入控制器
    }
  }
  ```



### 4、扩展配置

+ 项目提供了通用的AppBar小部件，如果要使用AppBar小部件，请将[图片资源](https://github.com/ilovesshan/flutter-common-utils-v2/tree/master/assets/common)`copy`到项目根路径 ` assets/common/` 目录下（也可自行替换图片，需要保证文件名称正确性）

  ```dart
  NavBar.showWidthPrimaryTheme("样式跟随主题色")
  NavBar.showWidthPrimaryTheme("简朴白色")
  ```

  

+ 项目集成了 flutter闪屏页插件，下面列举简单用法，具体用法请参考：[flutter_native_splash]( https://pub.dev/packages/flutter_native_splash)

  + 自定义闪屏页配置并将其添加到项目的`pubspec.yaml`文件中或放置在名为的根项目文件夹中的新文件中`flutter_native_splash.yaml`。

    ```yaml
    flutter_native_splash:
      background_image: "assets/launch_image.png"
    ```

    

  + 执行创建闪屏页命令（ios、android自动生成相关资源）

    ```dart
    flutter pub run flutter_native_splash:create
    ```

    

  + 恢复到默认状态

    ```dart
    flutter pub run flutter_native_splash:remove
    ```



### 5、启动过程中可能发生的错误

+ `uses-sdk:minSdkVersion 16 cannot be smaller than version 19 declared in library`

  ```groovy
  // build.gradle（项目级别 ）
  android {
      compileSdkVersion 31
  }
  ```

  

+ `Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && hasPermissionInManifest(context, null, permission ) `

  ```groovy
  // build.gradle（项目级别 ）
  android {
      //...
      defaultConfig {
          //...
          minSdkVersion 19
          targetSdkVersion 31
      }
  }
  ```

  

+ `com.android.builder.dexing.DexArchiveMergerException: Error while merging dex archives: 
  The number of method references in a .dex file cannot exceed 64K.1`

  ```groovy
  // build.gradle（项目级别 ）
  android {
      //...
      defaultConfig {
          //...
          multiDexEnabled true
      }
  }
  ```
  
  ```groovy
  // build.gradle（项目级别 ）
  dependencies{
      implementation 'androidx.multidex:multidex: 2.0.1'
  }
  ```

  
  
+ `Module was compiled with an incompatible version of Kotlin. The binary version of its metadata is 1.6.0, expected version is 1.1.15.`

  ```groovy
  // build.gradle（项目级别 ）
  dependencies {
      // 项目如果有自动生成请忽略（Android端基于kotlin语言）
      implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
  }
  ```

  ```groovy
  // build.gradle（工程级别 ）
  buildscript {
      // ....
      ext.kotlin_version = '1.6.10'
      dependencies {
          // 项目如果有自动生成请忽略（Android端基于kotlin语言）
          classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
      }
  }
  ```

  

+ 如果编译时提示关于语法/资源未找相关的警告/错误时，请尝试清空项目缓存以及androidStudio缓存

  + 清空项目缓存

    ```dart
    flutter clean
    ```

    

  + 清空androidStudio缓存

    ```dart
    File -> Invalidate Caches -> [勾选]Clear file system cache and Local History -> Invalidate and Restart
    ```

    

  + 拉取项目依赖

    ```dart
    flutter pub get
    ```

    



### 6、最后

本项目工具库会长期更新维护下去...
