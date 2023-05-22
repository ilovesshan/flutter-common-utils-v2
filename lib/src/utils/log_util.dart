import 'package:common_utils_v2/common_utils_v2.dart';

void printLog(StackTrace current, Object message) {
  if (kDebugMode) {
    try {
      LogTrace programInfo = LogTrace(current);
      debugPrint("${programInfo.fileName} || line: ${programInfo.lineNumber} || --> $message");
    } catch (e) {
      debugPrint("$message");
      debugPrint("日志工具异常：" + e.toString());
    }
  }
}

class LogTrace {
  final StackTrace _trace;
  String fileName = "";
  int lineNumber = 0;
  int columnNumber = 0;

  LogTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = _trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfo = fileInfo.split(":");
    fileName = listOfInfo[0];
    lineNumber = int.parse(listOfInfo[1]);
    var columnStr = listOfInfo[2];
    columnStr = columnStr.replaceFirst(")", "");
    columnNumber = int.parse(columnStr);
  }
}
