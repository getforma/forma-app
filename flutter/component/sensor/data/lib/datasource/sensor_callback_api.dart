import 'package:flutter/foundation.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';

class SensorCallbackApiImpl implements SensorCallbackApi {
  @override
  void onSensorDataRecorded(SensorData sensorData) {
    if (kDebugMode) {
      print(sensorData.stringify());
    }
  }
}

extension SensorDataString on SensorData {
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
