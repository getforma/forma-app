import 'package:core_component_data/database/model/app_configuration_table.dart';
import 'package:core_component_data/database/model/measurement_analysis_table.dart';
import 'package:core_component_data/database/model/measurement_table.dart';
import 'package:core_component_data/database/model/user_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

part 'app_database.g.dart';

@LazySingleton()
@DriftDatabase(tables: [
  MeasurementTable,
  MeasurementAnalysisTable,
  AppConfigurationTable,
  UserTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (openingDetails) async {
        // TODO: add migration strategy, for now it's easier to delete the database
        final m = Migrator(this);
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
      });

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'app_database');
  }
}
