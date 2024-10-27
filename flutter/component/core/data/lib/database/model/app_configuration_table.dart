import 'package:drift/drift.dart';

class AppConfigurationTable extends Table {
  TextColumn get key => textEnum<AppConfigurationKey>()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

enum AppConfigurationKey {
  isSensorConnected,
}
