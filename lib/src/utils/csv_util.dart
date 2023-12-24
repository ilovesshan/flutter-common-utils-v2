import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class CsvUtil {
  static Future<File> writeCSV({String? filename, required List<String> header, required List<List<String>> rows}) async {
    Directory temporaryDirectory = await getTemporaryDirectory();
    String targetFileName = filename ?? DateTime.now().millisecondsSinceEpoch.toString();
    File file = File(temporaryDirectory.path + "/csv/" + targetFileName + ".csv");
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    String csv = const ListToCsvConverter().convert([header, ...rows]);
    return await file.writeAsString(csv);
  }

  static Future<List<List<dynamic>>> readCSV({required String filePath}) async {
    File file = File(filePath);
    if (await file.exists()) {
      String contents = await file.readAsString();
      List<List<dynamic>> csvList = const CsvToListConverter().convert(contents);
      return csvList;
    } else {
      throw FileSystemException("File not found", filePath);
    }
  }

  static Future<List<File>> getCsvList() async {
    Directory temporaryDirectory = await getTemporaryDirectory();
    Directory csvDirectory = Directory(temporaryDirectory.path + "/csv");
    List<File> files = [];
    List<FileSystemEntity> temporaryDirectoryLis = csvDirectory.listSync();
    for (var element in temporaryDirectoryLis) {
      files.add(element as File);
    }
    return files;
  }
}
