import 'package:common_utils_v2/common_utils_v2.dart';

class Log {
  static final logger = Logger(
    ///  LogFilter filter:  过滤器, 区分开发环境与生产环境。 默认使用: DevelopmentFilter()
    ///  LogPrinter printer: 打印器, 控制日志输出样式和堆栈信息等。 默认使用: PrettyPrinter()
    ///  LogOutput output:  输出器, 控制日志输出位置,可以是控制台、文件、内存。默认使用:ConsoleOutput()
    output: AppConsoleOutput(),
  );

  /// Verbose
  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.v(message, error, stackTrace);
  }

  /// Debug
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error, stackTrace);
  }

  /// Info
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error, stackTrace);
  }

  /// Warning
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error, stackTrace);
  }

  /// Error
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error, stackTrace);
  }

  /// What a terrible failure log
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.wtf(message, error, stackTrace);
  }
}

/// 自定义输出器
class AppConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.removeAt(2);
    event.lines.forEach(print);
  }
}
