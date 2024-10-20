import 'package:core_component_data/database/model/measurement_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'app_database.g.dart';

@LazySingleton()
@DriftDatabase(tables: [MeasurementTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (openingDetails) async {
        if (kDebugMode) {
          final m = Migrator(this);
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
      });

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'app_database');
  }
}
