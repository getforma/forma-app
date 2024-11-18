import 'dart:async';

import 'package:core_component_data/database/app_database.dart';
import 'package:core_component_data/database/model/app_configuration_table.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:core_component_domain/app_configuration_repository.dart';

@LazySingleton(as: AppConfigurationRepository)
class AppConfigurationRepositoryImpl implements AppConfigurationRepository {
  final AppDatabase _database;

  StreamController<String?>? _currentSessionIdController;

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

  @override
  Future<void> setCurrentSessionId(String sessionId) async {
    await _database
        .into(_database.appConfigurationTable)
        .insertOnConflictUpdate(AppConfigurationTableCompanion(
            key: const Value(AppConfigurationKey.currentSessionId),
            value: Value(sessionId)));
  }

  void _subscribeToCurrentSessionId() {
    (_database.select(_database.appConfigurationTable)
          ..where(
              (t) => t.key.equals(AppConfigurationKey.currentSessionId.name)))
        .watchSingleOrNull()
        .map((configuration) => configuration?.value)
        .listen(_currentSessionIdController?.sink.add);
  }

  @override
  Stream<String?> getCurrentSessionIdStream() {
    if (_currentSessionIdController == null) {
      _currentSessionIdController = StreamController<String?>.broadcast();
      _subscribeToCurrentSessionId();
    }

    return _currentSessionIdController!.stream;
  }

  @override
  Future<String?> getCurrentSessionId() async {
    return (await _database
            .select(_database.appConfigurationTable)
            .getSingleOrNull())
        ?.value;
  }

  @override
  Future<void> removeCurrentSessionId() async {
    await (_database.delete(_database.appConfigurationTable)
          ..where(
              (t) => t.key.equals(AppConfigurationKey.currentSessionId.name)))
        .go();
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await _database
        .into(_database.appConfigurationTable)
        .insertOnConflictUpdate(const AppConfigurationTableCompanion(
            key: Value(AppConfigurationKey.onboardingCompleted),
            value: Value("true")));
  }

  @override
  Future<bool> getOnboardingCompleted() async {
    return (await _database
                .select(_database.appConfigurationTable)
                .getSingleOrNull())
            ?.value ==
        "true";
  }

  @disposeMethod
  @override
  void dispose() {
    _currentSessionIdController?.close();
  }
}
