##  flutter-common-utils-v2

### 1、简介

+ flutter-common-utils-v2：基于dart API以及常用的三方插件封装的一个工具包，里面主要封装了日常开发中常用的工具类以及通用Widget/page，工具包中对一些三方插件做了一层简单封装，具体引用可以查看pub文件清单。
+ flutter-common-utils-v2相较于flutter-common-utils更加轻量级。
+ flutter-common-utils-v2 能力简单介绍：
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
    + 常用正则表达式工具封装
    + 扫二维码/条形码
    + 音频录制/播放
    + RSA/MD5/Base64加解密工具
    + SharedPreferences封装
    + Sqlite工具封装
    + 字符串常用API封装
    + 时间日期转换
    + Toast轻提示
    + APP更新
    + ...

### 2、导入

+  flutter-common-utils-v2 工具包引用版本说明

  + flutter版本： 2.5.0 

  +  Dart sdk 版本： 2.14.0

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

+ 在项目入口文件main.dart进行配置（可以直接copy，再按需求修改即可）

  ```dart
  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:common_utils_v2/common_utils_v2.dart';
  
  void main() async {
    /// 添加Flutter全局异常捕获(可选)
    runZonedGuarded(() => runApp(const RootApplication()), (Object error, StackTrace stack) {
      /// 没有被我们代码catch到的异常
      Log.e(error.toString(), error, stack);
    });
  
    /// 初始化 SharedPreferences(可选)
    await SpUtil.initSharedPreferences();
      
    /// 初始化 Sqlite数据库(可选)
    await initSqliteDb();
  }
  
  class RootApplication extends StatefulWidget {
    const RootApplication({Key? key}) : super(key: key);
  
    @override
    State<RootApplication> createState() => _RootApplicationState();
  }
  
  class _RootApplicationState extends State<RootApplication> {
    @override
    Widget build(BuildContext context) {
      /// 实现清明灰色主题 Colors.transparent(正常) Colors.grey(清明灰)
      return ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color),
        /// 使用 GetMaterialApp替换MaterialApp
        child: GetMaterialApp(
          /// APP主题配色方案
          theme: AppInitialize.appTheme("2196f3"),
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
        ),
      );
    }
  }
  
  /// 初始化 Sqlite数据库（请适当对代码进行抽取）
  Future<void> initSqliteDb() async {
    /// 初始化数据库
    await SqliteHelperUtil.openDb(
      dbName: "user",
      version: 1,
      onCreate: (db, version) {
        Log.d("数据库初始化：version = $version");
        db.execute("""""");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        Log.d("数据库版本升级：oldVersion = $oldVersion, newVersion = $newVersion");
      },
      onDowngrade: (db, oldVersion, newVersion) {
        Log.d("数据库版本降低级：oldVersion = $oldVersion, newVersion = $newVersion");
      },
    );
  }
  
  /// 初始化bindings（请适当对代码进行抽取）
  class InitBinding implements Bindings {
    @override
    void dependencies() {
      Get.lazyPut(() => CountController());
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
        /// binding / bindings 是可选的，根据业务需求选择合适的解决方案即可
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
      /// 注入控制器...
    }
  }
  ```



### 4、扩展配置

+ 项目提供了通用的AppBar小部件，如果要使用AppBar小部件，请将[图片资源](https://github.com/ilovesshan/flutter-common-utils-v2/tree/master/assets/common)copy到项目根路径  assets/common/ 目录下（也可自行替换图片，需要保证文件名称正确性）

  ```dart
  /// 样式跟随主题色
  NavBar.showWidthPrimaryTheme("titleName")
  /// 简朴白色
  NavBar.showWidthPrimaryTheme("titleName")
  ```

  

+ 项目集成了 flutter闪屏页插件，下面列举简单用法，具体用法请参考：[flutter_native_splash]( https://pub.dev/packages/flutter_native_splash)

  + 自定义闪屏页配置并将其添加到项目的pubspec.yaml文件中或放置在名为的根项目文件夹中的新文件中flutter_native_splash.yaml。

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
  
  
  
+ 关于RAS加解密说明，EncryptUtil 提供了两种方式进行RSA加解密。

  + 直接传入公钥或者私钥方式进行加解密

    ```
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2/vF49zKHdP0EY1B9Zim
    5t4X1GsnP1TEYgYMnWXQNLluWV53iInEJBmw/xf++Ohbgp7WhAFcjlRJ6Bxnqj6n
    CtAsXAjIXnv1UDCabw/pUb2Tm349I990wSGEeIbuSRPD/t1O4qOTgpvCWRDgVVfX
    PILWBkshMhQA7xs0LeEXtimtCLnjUywlXw+Hthlx2Zi6Ba656HKro9EPZ2BRGGUd
    mbPLWibeD7MF8ETz5R0w/N+3GyTnizPihsFU4sPOnWwhsR0FWz0i+uVeYrIkpyo6
    hkXFQMLt4RzA9VVsd+nk5h/SQ/NQ38VrpUlLfcL4K/pzUXCrJ6X5KYOIfEcG16QG
    sQIDAQAB
    -----END PUBLIC KEY-----
    ```

    ```
    -----BEGIN PRIVATE KEY-----
    MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDb+8Xj3Mod0/QR
    jUH1mKbm3hfUayc/VMRiBgydZdA0uW5ZXneIicQkGbD/F/746FuCntaEAVyOVEno
    HGeqPqcK0CxcCMhee/VQMJpvD+lRvZObfj0j33TBIYR4hu5JE8P+3U7io5OCm8JZ
    EOBVV9c8gtYGSyEyFADvGzQt4Re2Ka0IueNTLCVfD4e2GXHZmLoFrrnocquj0Q9n
    YFEYZR2Zs8taJt4PswXwRPPlHTD837cbJOeLM+KGwVTiw86dbCGxHQVbPSL65V5i
    siSnKjqGRcVAwu3hHMD1VWx36eTmH9JD81DfxWulSUt9wvgr+nNRcKsnpfkpg4h8
    RwbXpAaxAgMBAAECggEAOXZP39CJnzcBVyBd7WhdmIrFEMCYtOtQjQZlfyvcMhmJ
    4KBTev/5kzB+0nOTL7OKS9lv0XWFlswfrhjVX1wUSDfOjo/gvwWEM9kuTfqLCMYL
    a5+TGu7A0b4Om2krjz0xgj6O35a47nH/V0KYRtK2L2FBxM0VM76T6+FgROe6SOOn
    8BOvAiljHu+hzxOAx8T881daO2TpLXGcwSHcT8UfhIIiE7KBjqUmgDQwkBNcZvhd
    uhNsSMBjNpf0sws6N2bJ3fK/Yo+23obW03yKqdWOXZ1/QD8PfdRn1gkNn1HwNKTU
    JuC2K7gUNfHugYDywz2wL2YMiGwzBKOdVULMMPhzkQKBgQD3e2bOIcW5+OOeabIq
    gGBzoOLaElUwJtFKZBNPG84t+mfYAzwHYkf416WXsR6ql0mLsmZaKBGYk+H5/Kco
    1xxPfHlENHHZVfof1K1pQLxLoF9vW7rtMVT+CwdgbppBXoVDcqkri8h9aVPTPL/D
    q6a9qFfcTO+wlfnCgaxXqlDAtQKBgQDjjhPx8sf55G7dZjl9wzfgGjsBRxOeecWr
    dcfRy4S/WxTC0NwTNaPMyb534RbwHh/MDg9naoLg0kUZQ+AfzleUC5D/PI0G8fO7
    qADXenb2ZwflBkyw5JmSsk2iJ8tREFgLfqAKrGDTSVc33q6mfm+fZHvZsGVUgxvr
    riB1EZc3jQKBgFlUib9OIXkHheHgdRcyT55tLHVauLUwzcr0ZKPhfYLLKECoqjpg
    F2qTLIqcvF0HTtzGAHv6ip9wgdkigZQUUXu/imY8J/wzNJ3Yvt+HJnCF6uzfR5Hm
    hK9Oe9MrGTMPUzsNYFL/mdbq9f8BppaSlxVOdqhmfP5YpFa5R+Q87fkhAoGBAKnT
    rGEC72o5qOAFXdzVKEtRaD4A3MyGVxcq1NFnUZA6mpj2pXiUrMW2vzbav3K/GL4C
    tE5bOIgvhbBgbtFt/wCXTUSf3SSUyHGB5fbrCAPHSyYK+IuAYHkSJ0xg5KWATCVw
    AGNW2QB3GOeygqfxbr8HkEMcGdPj8Z+IGeMlGLU1AoGBANpu3Sx5J6ELxpL3110I
    6GfhmADZ/k8rTlkST+sfUJI1R3TcKqLBbyiNd1id1O1rKrnPfym41lNWz6MWRn6m
    1GPrdTNZIfMJugEfJyaF2vojWyFXMEA/pvjfHeEjQLsoEoupKXLH/Tkm6zaNunJH
    cX2rgz3C2PGugq1h2EZGBU5z
    -----END PRIVATE KEY-----
    ```

    

    ```dart
    /// 加密
    String encodeRsa = EncryptUtil.encodeRsa(content: "123", publicKeyStr: "publicKey");
    
    /// 解密
    String decodeRsa = EncryptUtil.decodeRsa(content: encodeRsa, privateKeyStr: "privateKey");
    ```

    

  + 通过 rootBundle.loadString('path') 取读取公钥或者私钥配文件方式进行加解密，需要注意：公钥或者私钥配文件要在pub.yaml中进行声明。

    ```yaml
    flutter:
      assets:
        - assets/key/
    ```

    

    ```
    /// RAS加密(通过读取public.pem私钥文件)
    String encodeRsaLoadByFile = await EncryptUtil.encodeRsaLoadByFile(content: "123", publicKeyFilePath: "assets/key/public.pem");
    
    /// RAS解密(通过读取private.pem私钥文件)
    String decodeRsaLoadByFile = await EncryptUtil.decodeRsaLoadByFile(content: encodeRsa, privateKeyFilePath: "assets/key/private.pem");
    ```

    

  

### 5、启动过程中可能发生的错误

+ uses-sdk:minSdkVersion 16 cannot be smaller than version 19 declared in library

  ```groovy
  // build.gradle（项目级别 ）
  android {
      compileSdkVersion 31
  }
  ```

  

+ Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && hasPermissionInManifest(context, null, permission ) 

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

  

+ com.android.builder.dexing.DexArchiveMergerException: Error while merging dex archives: 
  The number of method references in a .dex file cannot exceed 64K.1

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

  
  
+ Module was compiled with an incompatible version of Kotlin. The binary version of its metadata is 1.6.0, expected version is 1.1.15.

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
