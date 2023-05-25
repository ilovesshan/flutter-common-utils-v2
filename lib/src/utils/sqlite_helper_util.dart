import 'package:common_utils_v2/common_utils_v2.dart';

class SqliteHelperUtil {
  static late Database _database;

  static Database get database => _database;

  /// 数据库初始化/数据库版本升级
  static Future<void> openDb({
    required String dbName,
    required int version,
    required OnDatabaseCreateFn onCreate,
    required OnDatabaseVersionChangeFn onUpgrade,
    OnDatabaseConfigureFn? onConfigure,
    OnDatabaseVersionChangeFn? onDowngrade,
    OnDatabaseOpenFn? onOpen,
    bool readOnly = false,
    bool singleInstance = true,
  }) async {
    final dbParentPath = await getDatabasesPath();
    final dbPath = join(dbParentPath, dbName.contains(".db") ? dbName : "$dbName.db");

    _database = await openDatabase(
      dbPath,
      version: version,

      ///  Prototype of the function called before calling [onCreate]/[onUpdate]/[onOpen]
      onConfigure: onConfigure,

      /// Prototype of the function called when the database is created.
      onCreate: onCreate,

      /// Prototype of the function called when the version has changed.
      onUpgrade: onUpgrade,

      ///  Prototype of the function called when the version has changed.
      onDowngrade: onDowngrade,

      /// Prototype of the function called when the database is open.
      onOpen: onOpen,
    );
  }

  /// 获取数据库状态(开启/关闭)
  static bool isOpen({String? dbPath}) {
    return _database.isOpen;
  }

  /// 获取数据库版本
  static Future<void> getVersion() {
    return _database.getVersion();
  }

  /// 更新数据库版本
  static Future<void> setVersion(int version) {
    return _database.setVersion(version);
  }

  /// 删除数据库
  static Future<void> dropDb({String? dbPath}) async {
    return await deleteDatabase(dbPath ?? _database.path);
  }

  ///关闭数据库
  static Future<void> closeDb() async {
    return await closeDb();
  }

  /// 添加表
  static Future<void> addTable({required String sql}) async {
    return await _database.execute(sql);
  }

  /// 删除表
  static Future<void> dropTable({required String tbName}) async {
    return await _database.execute("drop table $tbName");
  }

  /// 清空表
  static Future<void> deleteTable({required String tbName}) async {
    return await _database.execute("delete from $tbName");
  }

  /// 重命名表
  static Future<void> renameTable({required String oldTbName, required String newTbName}) async {
    return await _database.execute("alter table $oldTbName rename to $newTbName");
  }

  /// 删除表字段
  static Future<void> dropColumn({required String tbName, required String columnName}) async {
    return await _database.execute("alter table $tbName drop column $columnName");
  }

  /// 新增数据 Returns the last inserted record id
  static Future<int> rowInsert(String sql, [List<Object?>? arguments]) async {
    return await _database.rawInsert(sql, arguments);
  }

  /// 删除数据 Returns the number of changes made
  static Future<int> rawDelete(String sql, [List<Object?>? arguments]) async {
    return await _database.rawDelete(sql, arguments);
  }

  /// 更新数据 Returns the number of changes made
  static Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    return await _database.rawUpdate(sql, arguments);
  }

  ///查询数据
  static Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<Object?>? arguments]) async {
    return await _database.rawQuery(sql, arguments);
  }
}
