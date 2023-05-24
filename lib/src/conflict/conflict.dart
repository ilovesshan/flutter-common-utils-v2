/// getx的FormData和Dio的FormData冲突 暂时屏蔽
/// export 'package:get/get_connect/connect.dart';

export 'package:get/get_common/get_reset.dart';
export 'package:get/get_core/get_core.dart';
export 'package:get/get_instance/get_instance.dart';
export 'package:get/get_navigation/get_navigation.dart';
export 'package:get/get_rx/get_rx.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:get/get_utils/get_utils.dart';
export 'package:get/route_manager.dart';

/// flutter_typeahead的ErrorBuilder和Provider的ErrorBuilder冲突 暂时屏蔽
// export 'package:flutter_typeahead/src//typedef.dart'
//     show
//     SuggestionsCallback,
//     ItemBuilder,
//     SuggestionSelectionCallback,
//     AnimationTransitionBuilder;
//
//
// export 'package:flutter_typeahead/src//flutter_typeahead.dart';
// export 'package:flutter_typeahead/src//cupertino_flutter_typeahead.dart';


/// 解决 sqflite和floor 冲突
export 'package:sqflite/src/compat.dart';
export 'package:sqflite/src/constant.dart';
export 'package:sqflite/src/factory_impl.dart' show databaseFactory;
export 'package:sqflite/src/sqflite_impl.dart';
export 'package:sqflite/src/utils.dart';
export 'package:sqflite_common/utils/utils.dart' hide lockWarningCallback, lockWarningDuration;
export 'package:sqflite/sql.dart';
export 'package:sqflite/src/compat.dart';
export 'package:sqflite/src/factory_impl.dart' hide sqfliteDatabaseFactory;
export 'package:sqflite_common/sqlite_api.dart' hide Database;
