import 'package:core_component_data/database/app_database.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
import 'package:session_component_domain/model/measurement.dart';

extension MeasurementTableDataMapper on MeasurementTableData {
  Measurement toMeasurement() {
    return Measurement(
      time: timestamp,
      latitude: latitude,
      longitude: longitude,
      acceleration: ThreeAxisMeasurement(
        x: accelerationX,
        y: accelerationY,
        z: accelerationZ,
      ),
      angularVelocity: ThreeAxisMeasurement(
        x: angularVelocityX,
        y: angularVelocityY,
        z: angularVelocityZ,
      ),
      magneticField: ThreeAxisMeasurement(
        x: magneticFieldX,
        y: magneticFieldY,
        z: magneticFieldZ,
      ),
      angle: ThreeAxisMeasurement(
        x: angleX,
        y: angleY,
        z: angleZ,
      ),
    );
  }
}

