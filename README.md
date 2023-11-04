##  flutter-common-utils-v2

### 1、简介

+ flutter-common-utils-v2：基于dart API以及常用的三方插件封装的一个工具包，里面主要封装了日常开发中常用的工具类以及通用Widget/page，工具包中对一些三方插件做了一层简单封装，具体引用可以查看pub文件清单。
+ flutter-common-utils-v2相较于flutter-common-utils更加轻量级。
+ flutter-common-utils-v2 能力简单介绍：
  + 小部件
    +  AppBar
    +  BottomBar
    +  Dialog
    +  LoadingWidget、EmptyWidget、ErrorWidget
    +  底部弹框选择器
    +  跑马灯
    +  轮播图
    + ...
  + 页面
    + 图片预览
    + WebView
    + 二维码/条形码扫描
    + ...
  + 工具类
    + App配置信息
    + 颜色转换工具
    + 网络状态检测
    + 设备信息获取
    + 常用加解密工具（BASE64、MD5、RSA）
    + 基于发布订阅模式的EventBus
    + 文件压缩工具
    + 文件上传/文件下载
    + Dio网络请求封装
    + 图片/拍摄选择器
    + 处理地理位置信息（高德地图）
    + 日志输出
    + 调用三方地图导航（高德、百度、腾讯）
    + Notification 本地通知
    + APP信息获取
    + 权限申请
    + 扫二维码/条形码
    + 音频录制/播放
    + 常用正则表达式工具
    + SharedPreferences工具
    + SqliteHelper工具
    + 字节转换工具（B/KB/MB/GB）
    + 字符串常用API
    + 时间日期转换
    + Toast轻提示
    + APP更新
    + ...

### 2、导入

+ flutter-common-utils-v2 工具包引用版本说明

  + flutter版本： 3.13.9

  + Dart sdk 版本： 3.1.5

    ```
    Flutter 3.13.9 • channel stable • https://github.com/flutter/flutter.git
    Framework • revision d211f42860 (9 days ago) • 2023-10-25 13:42:25 -0700
    Engine • revision 0545f8705d
    Tools • Dart 3.1.5 • DevTools 2.25.0
    ```

    

+ 将项目clone到本地进入导入

  ```yaml
  common_utils_v2:
    path: ./flutter-common-utils-v2
  ```

  

+ 通过 git远程方式导入

  ```yaml
  common_utils_v2:
    git:
      url: https://github.com/ilovesshan/flutter-common-utils-v2.git
      ref: master
  ```

  

### 3、基本配置

+ 在项目入口文件main.dart进行配置（可以直接copy，再按需求修改即可）

  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  
    /// Flutter全局异常捕获(可选)
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      Log.wtf(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      Log.wtf(error);
      Log.wtf(stack.toString());
      return true;
    };
  
    /// 注入ApplicationService 用来初始化一些前置操作(可选)
    await Get.putAsync(() => ApplicationService().init());
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
      /// 实现清明灰色主题 Colors.transparent(正常) Colors.grey(清明灰)
      return ColorFiltered(
        colorFilter: ColorFilter.mode(ApplicationService.isOpenLucidGray ? Colors.grey : Colors.transparent, BlendMode.color),
  
        /// 使用 GetMaterialApp替换MaterialApp
        child: GetMaterialApp(
          /// APP主题配色方案
          theme: AppUtil.appTheme("2196f3"),
  
          debugShowCheckedModeBanner: false,
  
          /// 使用Get提供的路由解决方案(也可自行选择其他三方库)
          initialRoute: AppRouter.initRoute,
          getPages: AppRouter.routes(),
          onUnknownRoute: (routeSettings) => AppRouter.onUnknownRoute(routeSettings),
          routingCallback: (routing) => AppRouter.routingCallback(routing!),
  
          /// 顶层视图的key可以获取OverlayState对象
          navigatorKey: ApplicationService.navigatorKey,
  
          /// 如果未使用GetMaterialApp ,则可以通过navigatorObservers来观察路由变化
          navigatorObservers: [ApplicationController.routeObserver, BotToastNavigatorObserver()],
  
          /// Get控制器的管理机制,默认 SmartManagement.full
          smartManagement: SmartManagement.full,
  
          /// 国际化
          locale: I18nService.locale,
          fallbackLocale: I18nService.fallbackLocale,
          translations: I18nService(),
          localizationsDelegates: AppUtil.internationalization(),
  
          builder: (context, child) {
            /// android状态栏为透明沉浸式
            AppUtil.setSystemUiOverlayStyle();
  
            /// 屏幕适配
            AppUtil.initScreenUtil(context);
            child = GestureDetector(
              child: child!,
  
              /// 点击空白区域关闭键盘
              onTap: () => AppUtil.closeKeyBord(context),
            );
  
            /// 使用 botToast 还是 flutterEasyLoading
            if (!ApplicationService.enableFlutterEasyLoading) {
              final TransitionBuilder botToastTsBuilder = BotToastInit();
              return botToastTsBuilder(context, child);
            } else {
              final TransitionBuilder easyLoadingTsBuilder = EasyLoading.init();
              return easyLoadingTsBuilder(context, child);
            }
          },
        ),
      );
    }
  }
  ```
  
  
  
+ ApplicationController(可选，仅供参考)

  ```dart
  class ApplicationController extends SuperController {
    /// 路由观察对象
    static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  
    @override
    void onInit() async {
      super.onInit();
      Log.v("App onInit...");
    }
  
    @override
    void onDetached() {
      Log.v("App onDetached...");
    }
  
    @override
    void onInactive() {
      Log.v("App onInactive...");
    }
  
    @override
    void onPaused() {
      Log.v("App onPaused...");
    }
  
    @override
    void onResumed() async {
      Log.v("App onResumed...");
    }
  }
  ```
  
  
  
+ ApplicationService(可选，仅供参考)

  ```dart
  class ApplicationService extends GetxService {
    /// 通过顶层视图的key获取OverlayState对象
    static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  
    /// 是否开启清明灰主题
    static bool isOpenLucidGray = false;
  
    /// 是否启用flutter_easyloading（默认启用bot_toast）
    static bool enableFlutterEasyLoading = false;
  
    /// 执行初始化操作
    Future<ApplicationService> init() async {
      
      /// 启动Dart后台任务调度(可选)
      AppTask.registerTask();
  
      /// 初始化 SharedPreferences(可选)
      await SpUtil.initSharedPreferences();
  
      /// 初始化Flutter本地推送(可选)
      await NotificationUtil.initNotification(notificationCallback: (String? payload) async {
        Log.e("current notification clicked result payload: $payload");
      });
  
      /// 初始化geolocator位置服务（可选）
      if (Platform.isAndroid) {
        GeolocatorAndroid.registerWith();
      }
  
      /// 这里可以做本地业务判断(今天是否是清明节)
      await Future.delayed(const Duration(milliseconds: 500), () => isOpenLucidGray = false);
  
      return this;
    }
  }
  ```
  
  
  
+ I18nService(可选，仅供参考)

  ```dart
  import 'package:flutter/material.dart';
  import 'package:common_utils_v2/common_utils_v2.dart';
  
  class I18nService extends Translations {
    /// 默认展示本地语言
    static const locale = Locale('zh', 'CN');
  
    /// 语言选择无效时备用语言
    static const fallbackLocale = Locale('zh', 'CN');
  
    /// 需要国际化的文字key
    static const String mainText = "mainText";
    static const String language = "language";
  
    @override
    Map<String, Map<String, String>> get keys => {
          /// 配置中文
          'zh_CN': {
            I18nService.mainText: "你好，世界~",
            I18nService.language: "中文",
          },
  
          /// 配置英文
          'en_US': {
            I18nService.mainText: "hello world~",
            I18nService.language: "english",
          },
        };
  }
  
  ```
  
  
  
+ AppTask(可选，仅供参考)

  ```dart
  import 'package:common_utils_v2/common_utils_v2.dart';
  
  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      Log.e("task == $task, inputData == $inputData");
      switch (task) {
        case "simpleTask":
          Log.d("simpleTask execute...");
          NotificationUtil.notifyMessage(title: inputData!["title"], body: inputData["body"]);
          break;
        case "PeriodicTask":
          Log.d("PeriodicTask execute...");
          NotificationUtil.notifyMessage(title: inputData!["title"], body: inputData["body"]);
          break;
      }
      return Future.value(true);
    });
  }
  
  class AppTask {
    static void registerTask() {
      String curDateText = DateFormat("yyyy年MM月dd日 hh时mm分ss秒").format(DateTime.now());
  
      Workmanager().initialize(
        /// 该回调函数需要是一个顶级函数
        callbackDispatcher,
  
        /// 开启debug调式模式
        isInDebugMode: true,
      );
  
      /// 注册一次性任务
      Workmanager().registerOneOffTask("simpleTaskId", "simpleTask", inputData: {
        "title": "Flutter 任务调度",
        "body": "$curDateText 任务调度（simpleTask）",
      });
  
      /// 注册周期性任务（默认15分钟执行一次）
      Workmanager().registerPeriodicTask("PeriodicTaskId", "PeriodicTask", inputData: {
        "title": "Flutter 任务调度",
        "body": "$curDateText 任务调度（PeriodicTask）",
      });
    }
  }
  
  ```
  
  
  
+ AppRouter(仅供参考)

  ```dart
  import 'package:flutter/material.dart';
  import 'package:common_utils_v2/common_utils_v2.dart';
  
  class AppRouter {
    static const String initRoute = home;
    static const String login = "/login";
    static const String register = "/register";
    static const String home = "/home";
  
    /// 路由表
    static List<GetPage> routes() {
      return [
        /// binding、middlewares和bindings属性(可选) 按需求配置即可
        GetPage(
          name: login,
          page: () => const LoginPage(),
          binding: BindingsBuilder(() => Get.lazyPut(() => HomeController())),
        ),
        GetPage(
          name: register,
          page: () => const RegisterPage(),
          bindings: [RegisterPageBinding()],
        ),
        GetPage(
          name: home,
          page: () => const HomePage(),
          binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
          /// 使用中间件来限制用户需要登录才能访问该页面
          middlewares: [LoginMiddleware()],
        ),
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
    static ValueChanged<Routing?>? routingCallback(Routing routing) {}
  }
  ```
  
  
  
+ bingding类(可选，仅供参考)

  ```dart
  /// RegisterController
  class RegisterController extends GetxController {}
  
  /// RegisterPageBinding
  class RegisterPageBinding extends Bindings {
    @override
    void dependencies() {
      Get.lazyPut(() => RegisterController());
    }
  }
  ```
  
  
  
+ 路由中间件(可选，仅供参考)

  ```dart
  ///登录验证中间件
  class LoginMiddleware extends GetMiddleware {
    @override
    int? get priority => 0;
  
    ///进入目标页面之前将调用该函数
    @override
    RouteSettings? redirect(String? route) {
      /// 查询用户登录状态
      bool isLogin = Random().nextBool();
      if (isLogin) {
        return super.redirect(route);
      } else {
        return const RouteSettings(name: AppRouter.login);
      }
    }
  }
  ```



### 4、扩展配置

+ 清单文件中常用的权限列表

  ```xml
  <!-- 网络访问权限 -->
  <uses-permission android:name="android.permission.INTERNET" />
  
  <!--用于获取运营商信息，用于支持提供运营商信息相关的接口-->
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  
  <!--用于读取手机当前的状态-->
  <uses-permission android:name="android.permission.READ_PHONE_STATE" />
  
  <!-- 存储权限 -->
  <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
  <!-- 允许应用程序访问设备的相机，用于拍照和录制视频 -->
  <uses-permission android:name="android.permission.CAMERA" />
  <!-- 允许应用程序读取设备上的照片、视频和其他媒体文件 -->
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  <!-- 允许应用程序将照片、视频和其他媒体文件保存到设备的外部存储 -->
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  <!-- 允许应用程序读取设备上的音频文件，用于播放音乐或其他音频操作 -->
  <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
  <!-- 允许应用程序将音频文件保存到设备上，例如录制音频或保存音乐文件 -->
  <uses-permission android:name="android.permission.WRITE_MEDIA_AUDIO" />
  <!-- 允许应用程序读取设备上的图像文件，用于显示照片或进行图像处理 -->
  <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
  <!-- 允许应用程序将图像文件保存到设备上，例如拍照或保存图像文件 -->
  <uses-permission android:name="android.permission.WRITE_MEDIA_IMAGES" />
  <!-- 允许应用程序读取设备上的视频文件，用于播放视频或其他视频操作 -->
  <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
  <!-- 允许应用程序将视频文件保存到设备上，例如录制视频或保存视频文件 -->
  <uses-permission android:name="android.permission.WRITE_MEDIA_VIDEO" />
  
  <!-- 定位权限 -->
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" /> <!-- 近似定位权限 -->
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" /> <!-- 精准定位权限 -->
  <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" /> <!-- 后台定位权限 api29，android10新增 -->
  <uses-permission android:name="android.permission.FOREGROUND_SERVICE" /> <!-- 允许应用程序在前台运行服务，并显示相关通知 -->
  <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" /> <!--用于访问wifi网络信息，wifi信息会用于进行网络定位-->
  <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" /> <!--用于获取wifi的获取权限，wifi信息会用来进行网络定位-->
  <uses-permission android:name="android.permission.ACCESS_LOCATION_EXTRA_COMMANDS" /> <!--用于申请调用A-GPS模块-->
  
  <!-- 电话权限 -->
  <uses-permission android:name="android.permission.CALL_PHONE" />
  <uses-permission android:name="android.permission.READ_PHONE_STATE" />  <!-- 允许应用程序读取手机状态和身份信息 -->
  
  <!-- 联系人权限 -->
  <uses-permission android:name="android.permission.READ_CONTACTS" />  <!-- 允许应用程序读取联系人信息 -->
  <uses-permission android:name="android.permission.WRITE_CONTACTS" />  <!-- 允许应用程序写入联系人信息 -->
  
  <!-- 短信权限 -->
  <uses-permission android:name="android.permission.SEND_SMS" />
  
  <!-- 麦克风权限 -->
  <uses-permission android:name="android.permission.RECORD_AUDIO" />
  
  <!-- 传感器权限 -->
  <uses-permission android:name="android.permission.BODY_SENSORS" />  <!-- 允许应用程序访问身体传感器（如心率监测器） -->
  
  <!-- 日历权限 -->
  <uses-permission android:name="android.permission.READ_CALENDAR" />  <!-- 允许应用程序读取日历事件 -->
  <uses-permission android:name="android.permission.WRITE_CALENDAR" />  <!-- 允许应用程序写入日历事件 -->
  
  <!-- 语音识别权限 -->
  <uses-permission android:name="android.permission.RECORD_AUDIO" />  <!-- 允许应用程序访问麦克风进行语音录制和识别 -->
  
  <!-- 通知权限 -->
  <uses-permission android:name="android.permission.VIBRATE" />  <!-- 允许应用程序控制手机振动 -->
  <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY" />  <!-- 允许应用程序访问通知策略 -->
  <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  
  <!-- 蓝牙权限 -->
  <uses-permission android:name="android.permission.BLUETOOTH" />  <!-- 允许应用程序访问蓝牙设备 -->
  <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />  <!-- 允许应用程序管理蓝牙设备 -->
  ```
  
  + 声明文件存储的读写访问权限时，请注意：在 Android 10（API 级别 29）及更高版本中，如果您的应用程序需要访问外部存储器上的文件，还需要在清单文件的 `application` 标签中添加以下代码：
  
    ```xml
    <application
        ...
        android:requestLegacyExternalStorage="true">
        ...
    </application>
    ```
  
    
  
+ 如果项目下载依赖很慢，可以尝试更换下载源。

  ```groovy
  // build.gradle（工程级别 ）
  
  // google()
  // mavenCentral()
  maven { url 'https://maven.aliyun.com/repository/google' }
  maven { url 'https://maven.aliyun.com/repository/central' }
  maven { url 'https://maven.aliyun.com/repository/public' }
  maven { url 'https://maven.aliyun.com/repository/gradle-plugin' }
  ```

  
  
+ 自定义打包名称

  ```groovy
  // build.gradle（项目级别 ）
  
  android {
      android.applicationVariants.all {
          variant ->
          variant.outputs.all {
              // apk文件名
              outputFileName = "Floating-${variant.name}-v${variant.versionName}.apk"
          }
      }
  }
  ```

  

+ 关于.jks文件的生成方式以及配置

  + 创建一个用于上传的密钥库，生成.jks文件

    ```
    keytool -genkey -v -keystore /D:/keys/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
    ```
  
    
  
  + 查看SHA值
  
    ```
    keytool -v -list -keystore /D:/keys/key.jks
    ```
  
    
  
  + 创建一个名为 `[project]/android/key.properties` 的文件，它包含了密钥库位置的定义，在替换内容时请去除 `< >` 括号
  
    ```properties
    storePassword=<password-from-previous-step>
    keyPassword=<password-from-previous-step>
    keyAlias=key
    storeFile=D:/keys/key.jks
    ```
  
    
  
  + 在  `[project]/android/app/build.gradle` 中配置签名
  
    ```groovy
    // 读取 key.properties
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }
    
    android {
        ...
        signingConfigs {
            release {
                keyAlias keystoreProperties['keyAlias']
                keyPassword keystoreProperties['keyPassword']
                storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                storePassword keystoreProperties['storePassword']
            }
        }
        buildTypes {
            release {
                signingConfig signingConfigs.release
            }
        }
        ...
    }
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
  
    


+ 关于调用LocationUtil工具类来获取/处理地理位置等信息时，需要在清单文件中声明对应权限并且进行初始化

  + 注意android工程需要支持AndroidX，具体参考：https://pub.flutter-io.cn/packages/geolocator

  + 清单文件中声明对应权限

    ```
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    ```

  + 进行初始化

    ```dart
    if (Platform.isAndroid) {
        GeolocatorAndroid.registerWith();
    }
    ```

  

+ 关于RAS加解密说明，EncryptUtil 提供了两种方式进行RSA加解密。

  + 直接传入公钥或者私钥方式进行加解密

    ```
    -----BEGIN PUBLIC KEY-----
    ......
    -----END PUBLIC KEY-----
    ```
    
    ```
    -----BEGIN PRIVATE KEY-----
    ......
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
          minSdkVersion 21
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
      implementation 'androidx.multidex:multidex:2.0.1'
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

    

  + 拉取项目依赖

    ```dart
    flutter pub get
    ```

    
    
  + 如果上述操作依然不能解决，请尝试清空androidStudio缓存

    ```tex
    File -> Invalidate Caches -> [勾选]Clear file system cache and Local History -> Invalidate and Restart



### 6、最后

本项目工具库会长期更新维护下去...
