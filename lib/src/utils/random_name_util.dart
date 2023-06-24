import 'package:common_utils_v2/common_utils_v2.dart';

class RandomNameUtil {
  /// Eli Murphy
  static String enName() => Username.en().fullname;

  /// Alexander Robertson, Lincoln Sullivan, Ezekiel Jenkins
  static List<String> enFullNames({int count = 3}) => Username.en().getFullnames(count: count);

  /// Mason Jackson, Gavin Jackson, Aubree Jackson
  static List<String> enFullNamesWithSurerName(String superName, {int count = 3}) => Username.en(surName: superName).getFullnames(count: count);

  /// 张三
  static String chName() => Username.cn().fullname;

  /// 李红梅, 李波, 邵玉兰, 史芳, 陶梓涵, 汪超
  static List<String> chFullNames({int count = 3}) => Username.cn().getFullnames(count: count);

  /// 王建军, 王敏, 王红, 王皓轩, 王波, 王梓宣
  static List<String> chFullNamesWithSurerName(String superName, {int count = 3}) => Username.cn(surName: superName).getFullnames(count: count);
}
