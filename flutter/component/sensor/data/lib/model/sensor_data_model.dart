import 'package:sensor_component_data/datasource/sensor_api.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';

extension SensorDataModelMapper on SensorDataModel {
  SensorData toDomain() => SensorData(
        name: name,
        acceleration: acceleration.toDomain(),
        angularVelocity: angularVelocity.toDomain(),
        magneticField: magneticField.toDomain(),
        angle: angle.toDomain(),
      );
}

extension ThreeAxisMeasurementMapper on ThreeAxisMeasurementModel {
  ThreeAxisMeasurement toDomain() => ThreeAxisMeasurement(
        x: x,
        y: y,
        z: z,
      );
}
