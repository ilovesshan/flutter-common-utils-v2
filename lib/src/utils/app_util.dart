import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

class AppUtil {
  /// 设置android状态栏为透明的沉浸
  static void setSystemUiOverlayStyle() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  ///设置状态栏主题
  static void setStatusBarTheme(bool isLight) {
    SystemUiOverlayStyle systemUiOverlayStyle;
    if (isLight) {
      systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light);
    } else {
      systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    }
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  ///显示状态栏
  static showStatusBar() {
    if (DeviceInfoUtil.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    }
  }

  ///隐藏状态栏
  static hideStatusBar() {
    if (DeviceInfoUtil.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  /// 初始化屏幕适配工具
  static void initScreenUtil(BuildContext context, {Size? size}) {
    ScreenUtil.init(context, designSize: size ?? const Size(375, 812));
  }

  /// 点击空白区域关闭键盘
  static void closeKeyBord(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// 国际化
  static Iterable<LocalizationsDelegate<dynamic>> internationalization() {
    Iterable<LocalizationsDelegate<dynamic>> iterable = [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
    return iterable;
  }

  /// APP 主题定制
  static ThemeData appTheme(String hexColor, {Color? color, Brightness? brightness}) {
    return ThemeData(
      brightness: brightness ?? Brightness.light,
      canvasColor: Colors.white,

      /// Material风格的组件提供主题色
      primarySwatch: ColorsUtil.createMaterialColor(color ?? Color(int.parse(hexColor, radix: 16) | 0xFF000000)),

      /// 应用程序主要部分（工具栏、标签栏等）的背景颜色
      primaryColor: color ?? Color(int.parse(hexColor, radix: 16) | 0xFF000000),

      /// BottomNavigationBar外观和布局
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: color ?? Color(int.parse(hexColor, radix: 16) | 0xFF000000),
        unselectedItemColor: color ?? Color(int.parse(hexColor, radix: 16) | 0xFF000000),
        selectedLabelStyle: TextStyle(color: color ?? Color(int.parse(hexColor, radix: 16) | 0xFF000000), fontSize: 10),
        unselectedLabelStyle: TextStyle(color: color ?? Color(int.parse(hexColor, radix: 16) | 0xFF000000), fontSize: 10),
      ),

      ///....
    );
  }
}

/// ThemeData 参数参照表
//  Brightness? brightness,     // 调整亮度白天模式和夜间模式
//  VisualDensity? visualDensity,     //视觉密度
//  MaterialColor? primarySwatch,     //Material风格的组件提供主题色
//  Color? primaryColor,     //应用程序主要部分（工具栏、标签栏等）的背景颜色
//  Brightness? primaryColorBrightness,     //确定放置在原色之上的文本和图标的颜色如工具栏文本本
//  Color? shadowColor,     //小部件的颜色（旋钮、文本、过度滚动边缘效果等）
//  Color? scaffoldBackgroundColor,     //页面的背景颜色。
//  Color? bottomAppBarColor,     //[BottomAppBar] 的默认颜色。
//  Color? cardColor,     //card的颜色
//  Color? dividerColor,     //[Divider]s和[PopupMenuDivider]的颜色，使用[ListTile] 之间，[DataTable]中的行之间，等等。
//  Color? focusColor,     //使用的焦点颜色表示组件具有输入焦点
//  Color? hoverColor,     //用于指示指针悬停颜色
//  Color? highlightColor,     //选择之后的颜色
//  Color? splashColor,     //InkWell点击的水波纹颜色
//  InteractiveInkFeatureFactory? splashFactory,
//  Color? selectedRowColor,     //用于突出显示选定行的颜色
//  Color? unselectedWidgetColor,     //用于处于非活动状态（但已启用）的小部件的颜色
//  Color? disabledColor,     //一个禁用的复选框的颜色
//  ButtonThemeData? buttonTheme,     //定义按钮小部件的默认配置，如 [RaisedButton]和 [平面按钮]
//  ToggleButtonsThemeData? toggleButtonsTheme,     //定义 [ToggleButtons] 小部件的默认配置
//  Color? backgroundColor,     // 与 [primaryColor] 形成对比的颜色，例如 用作进度条的剩余部分
//  Color? dialogBackgroundColor,     //[Dialog] 元素的背景颜色
//  Color? indicatorColor,     //选项卡栏中选定选项卡指示器的颜色
//  Color? hintColor,     // 用于提示文本或占位符文本的颜色，例如 在 [TextField] 字段中
//  Color? errorColor,     //用于提示错误信息的文本颜色，例如 在 [TextField] 字段中
//  Color? toggleableActiveColor,     //用于突出显示 [Switch]、[Radio] 和 [Checkbox] 等可切换小部件的活动状态的颜色
//  String? fontFamily,     //字体
//  TextTheme? textTheme,     //颜色与卡片和画布颜色形成对比的文本
//  TextTheme? primaryTextTheme,     //与原色形成对比的文本主题
//  InputDecorationTheme? inputDecorationTheme,     //[InputDecorator]、[TextField] 的默认[InputDecoration] 值，和 [TextFormField] 都是基于这个主题
//  IconThemeData? iconTheme,     //与卡片和画布颜色形成对比的图标主题
//  IconThemeData? primaryIconTheme,     //与原色形成对比的图标主题
//  SliderThemeData? sliderTheme,     //用于渲染 [Slider] 的颜色和形状
//  TabBarTheme? tabBarTheme,    //用于自定义标签栏指示器的大小、形状和颜色的主题
//  TooltipThemeData? tooltipTheme,     //工具提示主题
//  CardTheme? cardTheme,     //用于渲染 [card] 的颜色和样式
//  ChipThemeData? chipTheme,     //用于渲染 [Chip] 的颜色和样式
//  TargetPlatform? platform,     //设置平台，根据设置的平台会使用此平台的排版样式等
//  MaterialTapTargetSize? materialTapTargetSize,     //配置某些 Material 小部件的命中测试大小
//  AppBarTheme? appBarTheme,     //自定义[AppBar]的颜色、高度、亮度、iconTheme和textTheme的主题
//  ScrollbarThemeData? scrollbarTheme,     //自定义[滚动条]颜色、粗细和形状的主题
//  BottomAppBarTheme? bottomAppBarTheme,     //自定义 [BottomAppBar] 的形状、高度和颜色的主题
//  ColorScheme? colorScheme,     //这个属性的添加比主题的高度设置晚得多特定颜色，如 [cardColor]、[buttonColor]、[canvasColor] 等。新组件可以根据 [colorScheme] 专门定义
//  DialogTheme? dialogTheme,    //用于自定义对话框形状的主题
//  FloatingActionButtonThemeData? floatingActionButtonTheme,    //用于自定义[FloatingActionButton] 的形状、高度和颜色的主题
//  NavigationBarThemeData? navigationBarTheme,    //用于自定义[NavigationBar] 背景颜色、文本样 式和图标主题的主题
//  NavigationRailThemeData? navigationRailTheme,    //用于自定义 [NavigationRail] 的背景颜色、 高度、文本样式和图标主题的主题
//  SnackBarThemeData? snackBarTheme,    //用于自定义 [SnackBar] 的颜色、形状、高度和行为的主题
//  BottomSheetThemeData? bottomSheetTheme,    //用于自定义底页颜色、高度和形状的主题
//  PopupMenuThemeData? popupMenuTheme,    //用于自定义弹出菜单的颜色、形状、高度和文本样式的主题
//  MaterialBannerThemeData? bannerTheme,     //自定义 [MaterialBanner] 的颜色和文本样式的主题
//  DividerThemeData? dividerTheme,    //用于自定义[Divider]、[VerticalDivider] 等的颜色、粗细 和缩进的主题
//  ButtonBarThemeData? buttonBarTheme,    //用于自定义 [ButtonBar] 小部件的外观和布局的主题
//  BottomNavigationBarThemeData? bottomNavigationBarTheme,     //BottomNavigationBar外观和布局 的主题
//  TimePickerThemeData? timePickerTheme,    //用于自定义 timePicker  外观和布局的主题
//  TextButtonThemeData? textButtonTheme,    //用于自定义 [textButton] 外观和布局的主题
//  ElevatedButtonThemeData? elevatedButtonTheme,     //[elevatedButton]外观和布局的主题
//  OutlinedButtonThemeData? outlinedButtonTheme,     //[outlinedButton]外观和布局的主题
//  DataTableThemeData? dataTableTheme,    //用于自定义 [dataTable] 外观和布局的主题
//  CheckboxThemeData? checkboxTheme,    //用于自定义 [Checkbox] 小部件的外观和布局的主题
//  RadioThemeData? radioTheme,    //用于自定义 [radio] 小部件的外观和布局的主题
//  SwitchThemeData? switchTheme,     // 用于自定义 [Switch] 小部件外观和布局的主题
//  ProgressIndicatorThemeData? progressIndicatorTheme,    //用于自定义 [ProgressIndicator] 小 部件的外观和布局的主题
//  DrawerThemeData? drawerTheme,    //用于自定义 [Drawer] 小部件的外观和布局的主题
//  ListTileThemeData? listTileTheme,     // 用于自定义 [ListTile] 小部件外观的主题
