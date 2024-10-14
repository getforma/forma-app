import 'package:core_component_data/database/app_database.dart';
import 'package:core_component_data/database/model/measurement_table.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
import 'package:session_component_data/model/measurement_mapper.dart';
import 'package:session_component_domain/model/measurement.dart';
import 'package:session_component_domain/model/sensor_position.dart';

abstract class LocalSensorDataSource {
  Future<void> saveMeasurement({
    required SensorData data,
    required double longitude,
    required double latitude,
    required SensorPosition sensorPosition,
  });

  Future<List<Measurement>> getUnsynedMeasurements(String sessionId);

  Future<void> markDataAsSynced(String sessionId);
}

@LazySingleton(as: LocalSensorDataSource)
class DriftLocalSensorDataSource implements LocalSensorDataSource {
  final AppDatabase _database;

  DriftLocalSensorDataSource(this._database);

  @override
  Future<void> saveMeasurement({
    required SensorData data,
    required double longitude,
    required double latitude,
    required SensorPosition sensorPosition,
  }) async {
    final MeasurementSensorPosition _sensorPosition;
    switch (sensorPosition) {
      case SensorPosition.pelvisBack:
        _sensorPosition = MeasurementSensorPosition.pelvisBack;
        break;
      case SensorPosition.pelvisRight:
        _sensorPosition = MeasurementSensorPosition.pelvisRight;
        break;
      case SensorPosition.shinRight:
        _sensorPosition = MeasurementSensorPosition.shinRight;
        break;
      case SensorPosition.footRight:
        _sensorPosition = MeasurementSensorPosition.footRight;
        break;
    }

    await _database
        .into(_database.measurementTable)
        .insert(MeasurementTableCompanion(
          longitude: Value(longitude),
          latitude: Value(latitude),
          sensorPosition: Value(_sensorPosition),
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
        ));
  }

  @override
  Future<List<Measurement>> getUnsynedMeasurements(String sessionId) async {
    final unsynedData = await (_database.select(_database.measurementTable)
          ..where((tbl) =>
              tbl.sessionId.equals(sessionId) & tbl.isSynced.equals(false)))
        .get();
    return unsynedData.map((data) => data.toMeasurement()).toList();
  }

  @override
  Future<void> markDataAsSynced(String sessionId) async {
    await (_database.update(_database.measurementTable)
          ..where((tbl) => tbl.isSynced.equals(false)))
        .write(MeasurementTableCompanion(
      sessionId: Value(sessionId),
      isSynced: const Value(true),
    ));
  }
}
