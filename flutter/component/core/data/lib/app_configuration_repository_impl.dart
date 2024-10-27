import 'package:core_component_data/database/app_database.dart';
import 'package:core_component_data/database/model/app_configuration_table.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:core_component_domain/app_configuration_repository.dart';

@LazySingleton(as: AppConfigurationRepository)
class AppConfigurationRepositoryImpl implements AppConfigurationRepository {
  final AppDatabase _database;

  AppConfigurationRepositoryImpl(this._database);

  @override
  Stream<bool> getIsSensorConnectedStream() {
    return (_database.select(_database.appConfigurationTable)
          ..where(
              (t) => t.key.equals(AppConfigurationKey.isSensorConnected.name)))
        .watchSingleOrNull()
        .map((configuration) =>
            bool.tryParse(configuration?.value ?? "") == true);
  }

  @override
  Future<void> setIsSensorConnected(bool isConnected) async {
    await _database
        .into(_database.appConfigurationTable)
        .insertOnConflictUpdate(AppConfigurationTableCompanion(
            key: const Value(AppConfigurationKey.isSensorConnected),
            value: Value(
              isConnected.toString(),
            )));
  }
}
