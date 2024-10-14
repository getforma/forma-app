import 'package:injectable/injectable.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';
import 'package:sensor_component_domain/model/sensor_data.dart' as domain;
import 'package:session_component_domain/session_repository.dart';

@injectable
class SensorCallbackApiImpl implements SensorCallbackApi {
  final SessionRepository _sessionRepository;

  SensorCallbackApiImpl(this._sessionRepository);

  @override
  void onSensorDataRecorded(SensorDataModel sensorData) {
    _sessionRepository.storeMeasurementLocally(
        data: domain.SensorData(
      name: sensorData.name,
      acceleration: domain.ThreeAxisMeasurement(
        x: sensorData.acceleration.x,
        y: sensorData.acceleration.y,
        z: sensorData.acceleration.z,
      ),
      angularVelocity: domain.ThreeAxisMeasurement(
        x: sensorData.angularVelocity.x,
        y: sensorData.angularVelocity.y,
        z: sensorData.angularVelocity.z,
      ),
      magneticField: domain.ThreeAxisMeasurement(
        x: sensorData.magneticField.x,
        y: sensorData.magneticField.y,
        z: sensorData.magneticField.z,
      ),
      angle: domain.ThreeAxisMeasurement(
        x: sensorData.angle.x,
        y: sensorData.angle.y,
        z: sensorData.angle.z,
      ),
    ));
  }
}

extension SensorDataString on SensorDataModel {
  String stringify() {
    return """{
name: $name,
acceleration: { x: ${acceleration.x}, y: ${acceleration.y}, z: ${acceleration.z}},
angularVelocity:  { x: ${angularVelocity.x}, y: ${angularVelocity.y}, z: ${angularVelocity.z}},
magneticField:  { x: ${magneticField.x}, y: ${magneticField.y}, z: ${magneticField.z}},
angle:  { x: ${angle.x}, y: ${angle.y}, z: ${angle.z}},
}""";
  }
}
