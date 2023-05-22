import 'package:common_utils_v2/common_utils_v2.dart';

class ColorsUtil {
  /// 十六进制颜色 ==> Color
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(String hex, {double alpha = 1}) {
    final int result = _HexColor._getColorFromHex(hex);

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((result & 0xFF0000) >> 16, (result & 0x00FF00) >> 8, (result & 0x0000FF) >> 0, alpha);
  }


  /// Color => MaterialColor
  /// 调用的时候需要把hex改一下，比如 #223344 needs change to 0xFF223344 ,即把#换成0xFF即可
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}

/// 16进制字符串转成 int 类型 解析后台返回的字符串中包含 '#', '0x' 前缀, 或者包含透明度
class _HexColor extends Color {

  _HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = ((hexColor == null || hexColor.isEmpty) ? "#0A84FF" : hexColor).replaceAll("#", "");
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor == "NULL" ? "FF0A84FF" : hexColor, radix: 16);
  }
}
