import 'package:core_component_data/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';

abstract class LocalSensorDataSource {
  Future<void> saveSensorData(SensorData data);

  Future<List<SensorData>> getUnsynedSensorData(String sessionId);

  Future<void> markDataAsSynced(String sessionId);
}

@LazySingleton(as: LocalSensorDataSource)
class DriftLocalSensorDataSource implements LocalSensorDataSource {
  final AppDatabase _database;

  DriftLocalSensorDataSource(this._database);

  @override
  Future<void> saveSensorData(SensorData data) async {
    await _database.into(_database.sensorDataTable).insert(
          SensorDataTableCompanion(
            name: Value(data.name),
            accelerationX: Value(data.acceleration.x),
            accelerationY: Value(data.acceleration.y),
            accelerationZ: Value(data.acceleration.z),
            angularVelocityX: Value(data.angularVelocity.x),
            angularVelocityY: Value(data.angularVelocity.y),
            angularVelocityZ: Value(data.angularVelocity.z),
            magneticFieldX: Value(data.magneticField.x),
            magneticFieldY: Value(data.magneticField.y),
            magneticFieldZ: Value(data.magneticField.z),
            angleX: Value(data.angle.x),
            angleY: Value(data.angle.y),
            angleZ: Value(data.angle.z),
            timestamp: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<List<SensorData>> getUnsynedSensorData(String sessionId) async {
    final unsynedData = await (_database.select(_database.sensorDataTable)
          ..where((tbl) =>
              tbl.sessionId.equals(sessionId) & tbl.isSynced.equals(false)))
        .get();
    return unsynedData
        .map((data) => SensorData(
              name: data.name,
              acceleration: ThreeAxisMeasurement(
                  x: data.accelerationX,
                  y: data.accelerationY,
                  z: data.accelerationZ),
              angularVelocity: ThreeAxisMeasurement(
                  x: data.angularVelocityX,
                  y: data.angularVelocityY,
                  z: data.angularVelocityZ),
              magneticField: ThreeAxisMeasurement(
                  x: data.magneticFieldX,
                  y: data.magneticFieldY,
                  z: data.magneticFieldZ),
              angle: ThreeAxisMeasurement(
                  x: data.angleX, y: data.angleY, z: data.angleZ),
            ))
        .toList();
  }

  @override
  Future<void> markDataAsSynced(String sessionId) async {
    await (_database.update(_database.sensorDataTable)
          ..where((tbl) => tbl.isSynced.equals(false)))
        .write(SensorDataTableCompanion(
      sessionId: Value(sessionId),
      isSynced: Value(true),
    ));
  }
}
